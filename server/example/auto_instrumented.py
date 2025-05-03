# (1) Importing dependency
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Activation, Dropout, Flatten,\
 Conv2D, MaxPooling2D
from tensorflow.keras.layers import BatchNormalization
import numpy as np
from time import time
import math
from tensorflow.keras.callbacks import LearningRateScheduler
from tensorflow.keras.callbacks import ReduceLROnPlateau
from tensorflow.keras import backend as K
from sklearn.model_selection import train_test_split
from datetime import datetime


from dfa_lib_python.dataflow import Dataflow
from dfa_lib_python.transformation import Transformation
from dfa_lib_python.attribute import Attribute
from dfa_lib_python.attribute_type import AttributeType
from dfa_lib_python.set import Set
from dfa_lib_python.set_type import SetType
from dfa_lib_python.task import Task
from dfa_lib_python.dataset import DataSet
from dfa_lib_python.element import Element
from dfa_lib_python.task_status import TaskStatus

np.random.seed(1000)

# (2) Get Data
import tflearn.datasets.oxflower17 as oxflower17

# Prospective provenance capture
# Transformation MeshCreation

dataflow_tag = "alexnet-liliane-1"
exec_tag = dataflow_tag + str(datetime.now())
df = Dataflow(dataflow_tag)

# Prospective provenance capture
tf1 = Transformation("TrainingModel")
tf1_input = Set("iTrainingModel", SetType.INPUT, 
    [Attribute("OPTIMIZER_NAME", AttributeType.TEXT), 
    Attribute("LEARNING_RATE", AttributeType.NUMERIC),
    Attribute("NUM_EPOCHS", AttributeType.NUMERIC),
    Attribute("NUM_LAYERS", AttributeType.NUMERIC)])
tf1_output = Set("oTrainingModel", SetType.OUTPUT, 
    [Attribute("LOSS", AttributeType.NUMERIC),
    Attribute("ACCURACY", AttributeType.NUMERIC),
    Attribute("MODEL_PATH", AttributeType.TEXT)])
tf1.set_sets([tf1_input, tf1_output])
df.add_transformation(tf1)
df.save()   

x, y = oxflower17.load_data(one_hot=True)


epochs =2
class Monitor(tf.keras.callbacks.Callback):
    
    def __init__(self):
        self.epoch_num = 0
        self.start_time = None

    def on_epoch_begin(self, epoch, logs=None):
        self.start_time = time()
        self.epoch_num +=1
        # print(logs)

    def on_epoch_end(self, epoch, logs=None):
        elapsed_time = time()-self.start_time
        # print(logs)

class LearningRateScheduler(tf.keras.callbacks.Callback):
    """Learning rate scheduler.
    # Arguments
        schedule: a function that takes an epoch index as input
            (integer, indexed from 0) and current learning rate
            and returns a new learning rate as output (float).
        verbose: int. 0: quiet, 1: update messages.
    """
    def __init__(self, schedule, verbose=0):
        super(LearningRateScheduler, self).__init__()
        self.schedule = schedule
        self.verbose = verbose
        self.epoch_num = 0
        self.start_time = None       
        self.adaptation_id = 0


    def on_epoch_begin(self, epoch, logs=None):
        self.start_time = time()
        self.epoch_num +=1

        if not hasattr(self.model.optimizer, 'lr'):
            raise ValueError('Optimizer must have a "lr" attribute.')
        lr = float(K.get_value(self.model.optimizer.lr))
        temp_lr = lr
        try:  # new API
            print("before: " + str(lr))
            lr = self.schedule(epoch, lr)
        except TypeError:  # old API for backward compatibility
            lr = self.schedule(epoch)
        print("after: " + str(lr))            
        if not isinstance(lr, (float, np.float32, np.float64)):
            raise ValueError('The output of the "schedule" function '
                             'should be float.')
        if (round(temp_lr, 5) != lr):
            self.adaptation_id += 1
            print(round(temp_lr, 5))
            print(lr)
            K.set_value(self.model.optimizer.lr, lr)
            print(epoch)
            print(epochs)
            print(epoch==epochs)
 
            #adicionar ao dataset
        if self.verbose > 0:
            print('\nEpoch %05d: LearningRateScheduler setting learning '
                  'rate to %s.' % (epoch + 1, lr))

    def on_epoch_end(self, epoch, logs=None):
        elapsed_time = time()-self.start_time        
        logs = logs or {}
        print(K.eval(self.model.optimizer.lr))
        logs['lr'] = K.get_value(self.model.optimizer.lr)


initial_lrate = 0.002
drop = 0.5
epochs_drop = 10.0
adaptation_id = 0
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2,shuffle = True)

     
# learning rate schedule
def step_decay(epoch):
    print("Step Decay")  
    lrate = initial_lrate * math.pow(drop, math.floor((1+epoch)/epochs_drop))
    print("Step Decay", lrate)
    return lrate


# (3) Create a sequential model
model = Sequential()

# 1st Convolutional Layer
model.add(Conv2D(filters=96, input_shape=(224,224,3), kernel_size=(11,11),\
 strides=(4,4), padding='valid'))
model.add(Activation('relu'))
# Pooling
model.add(MaxPooling2D(pool_size=(2,2), strides=(2,2), padding='valid'))
# Batch Normalisation before passing it to the next layer
model.add(BatchNormalization())

# 2nd Convolutional Layer
model.add(Conv2D(filters=256, kernel_size=(11,11), strides=(1,1), padding='valid'))
model.add(Activation('relu'))
# Pooling
model.add(MaxPooling2D(pool_size=(2,2), strides=(2,2), padding='valid'))
# Batch Normalisation
model.add(BatchNormalization())

# 3rd Convolutional Layer
model.add(Conv2D(filters=384, kernel_size=(3,3), strides=(1,1), padding='valid'))
model.add(Activation('relu'))
# Batch Normalisation
model.add(BatchNormalization())

# 4th Convolutional Layer
model.add(Conv2D(filters=384, kernel_size=(3,3), strides=(1,1), padding='valid'))
model.add(Activation('relu'))
# Batch Normalisation
model.add(BatchNormalization())

# 5th Convolutional Layer
model.add(Conv2D(filters=256, kernel_size=(3,3), strides=(1,1), padding='valid'))
model.add(Activation('relu'))
# Pooling
model.add(MaxPooling2D(pool_size=(2,2), strides=(2,2), padding='valid'))
# Batch Normalisation
model.add(BatchNormalization())

# Passing it to a dense layer
model.add(Flatten())
# 1st Dense Layer
model.add(Dense(4096, input_shape=(224*224*3,)))
model.add(Activation('relu'))
# Add Dropout to prevent overfitting
model.add(Dropout(0.4))
# Batch Normalisation
model.add(BatchNormalization())

# 2nd Dense Layer
model.add(Dense(4096))
model.add(Activation('relu'))
# Add Dropout
model.add(Dropout(0.4))
# Batch Normalisation
model.add(BatchNormalization())

# 3rd Dense Layer
model.add(Dense(1000))
model.add(Activation('relu'))
# Add Dropout
model.add(Dropout(0.4))
# Batch Normalisation
model.add(BatchNormalization())

# Output Layer
model.add(Dense(17))
model.add(Activation('softmax'))

model.summary()

optimizer = tf.keras.optimizers.Adam(learning_rate=0.001)

t1 = Task(1, dataflow_tag,"TrainingModel")
tf1_input = DataSet("iTrainingModel", [Element([optimizer.get_config()['name'], optimizer.get_config()['learning_rate'], epochs, len(model.layers)])])
t1.add_dataset(tf1_input)
t1.begin() 

# (4) Compile
model.compile(loss='categorical_crossentropy', optimizer='adam',\
 metrics=['accuracy'])


monitor_callback = Monitor()
lrate = LearningRateScheduler(step_decay, verbose=1)

# (5) Train
#model.fit(x, y, batch_size=64, epochs=1, verbose=1, \validation_split=0.2, shuffle=True)
#lrate =ReduceLROnPlateau(monitor='val_acc', factor=0.2, patience=5, verbose=1, mode='auto', min_delta=0.0001, cooldown=0, min_lr=0)

model.fit(x_train, y_train, batch_size=64,epochs=epochs, callbacks=[monitor_callback, lrate], verbose=1, validation_split=0.2, shuffle=True)

a = model.evaluate(x_test, y_test)
print("test: " + str(a))

t1_output = DataSet("oTrainingModel", [Element([a[0], a[1], "/c/Users/debor/Desktop/model.json"])])
t1.add_dataset(t1_output)
t1.end()

