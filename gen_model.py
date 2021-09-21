from tensorflow import keras
from tensorflow.keras import layers
from tensorflow.keras import activations

import coremltools as ct

input = keras.Input(shape=[100, 100, 3])
x = layers.Conv2D(16, [3, 3], padding='same')(input)
for i in range(100):
    x = layers.Conv2D(16, [3, 3], padding='same')(x)
output = layers.Conv2D(3, [3, 3], padding='same')(x)

model = keras.Model(input, output)
model.compile(optimizer='adam', loss='mse')

mlmodel = ct.convert(model, minimum_deployment_target=ct.target.iOS15, compute_precision=ct.precision.FLOAT32)
mlmodel.save('Model.mlpackage')
