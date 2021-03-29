# Исследование влияния различных техник аугментации данных на процесс обучения нейронной сети на примере решения задачи классификации Oregon Wildlife с использованием техники обучения Transfer Learning
Аугментация данных предполагает увеличение выборки данных для обучения через модификацию существующих данных, для большего разнообразия и увеличения количества изображений. В данной лабораторной работе будут использоваться следующие техники аугментации данных:  
+ Манипуляции с яркостью и контрастом  
+ Поворот изображения на случайный угол  
+ Использование случайной части изображения  
+ Добавление случайного шума  
В данной лабораторной работе для решения задачи классификации изображений Oregon Wildlife использовалась нейронная сеть EfficientNet-B0, причем данная нейронная сеть будет иметь уже предобученные веса на базе изображений ImageNet. В качестве политики изменения темпа обучения была использована политика экспоненциального затухания с оптимальными параметрами initial_lrate = 0.01 и k = 0.3 (initial_lrate - начальный темп обучения, k - коэффициент наклона экспоненциальной кривой).  
## С использованием техники обучения Transfer Learning и оптимальной политики изменения темпа обучения обучить нейронную сеть EfficientNet-B0 (предварительно обученную на базе изображений imagenet) для решения задачи классификации изображений Oregon Wildlife с использованием следующих техник аугментации данных:
### 1. Манипуляция с яркостью и контрастом  
Данная техника аугментации данных предполагает изменение яркости и контрастности изображения. Для изменения контрастности использовалась следующая функция: 
```
tf.image.adjust_contrast(images, contrast_factor)
```
images - входное изображение (размер 224x224x3).  
contrast_factor - множитель для регулировки контраста.
```
def contrast(image, label):  
  return tf.image.adjust_contrast(image, 2), label
```  
Для изменения якрости использовалась следующая функция:  
```
tf.image.adjust_brightness(image, delta)
```
image - входное изображение (размер 224x224x3).    
delta - число добавляемое к значениям пикселей.
```
def brightness(image, label):  
  return tf.image.adjust_brightness(image, delta=0.3), label  
```
### Нахождение оптимальных параметров для манипуляции с яркостью и контрастом:  
Для нахождения оптимальных параметров, были проведены обучения с различными параметрами, такими как (contrast_factor - множитель для регулировки контраста, delta - число добавляемое к значениям пикселей для изменения яркости):  
+ contrast_factor = 2, delta = 0.3  
+ contrast_factor = 1, delta = 0.3  
+ contrast_factor = 0.5, delta = 0.5  
+ contrast_factor = 1, delta = 0.1  
+ contrast_factor = 3, delta = 0.1  
+ contrast_factor = 2, delta = 0.1  
#### В результате получили следующие графики в сравнении с политикой экспоненциального затухания с оптимальными параметрами initial_lrate = 0.01 и k = 0.3 без аугментации данных:  
+ График метрики точности для предобученной нейронной сети EfficientNet-B0 (манипуляция с яркостью и контрастом) для валидационного набора данных:

![legend_accuracy_brigthness_contrast](https://user-images.githubusercontent.com/59259102/112815848-6b4c1680-9089-11eb-9ef2-a06840cf72f3.png)  

<img src="./epoch_categorical_accuracy_brigtness_contrast.svg">

* График функции потерь для предобученной нейронной сети EfficientNet-B0 (манипуляция с яркостью и контрастом) для валидационного набора данных:  

![legend_loss_brightness_contrast](https://user-images.githubusercontent.com/59259102/112822862-29bf6980-9091-11eb-8989-d7d83ce88fc8.png)  
 

<img src="./epoch_loss_brightness_contrast.svg">


* Анализ полученных результатов  
Исходя из полученных результатов в качестве оптимальных параметров можно использовать: contrast_factor = 2, delta = 0.3 (contrast_factor - множитель для регулировки контраста, delta - число добавляемое к значениям пикселей для изменения яркости).
  + По сравнению с другими использовавшимися комбинациями:
    1. Одна из наибыстрейших скоростей схождения алгоритма (лучше только у комбинаций contrast_factor = 1, delta = 0.1 и contrast_factor = 3, delta = 0.1, но при таких комбинациях потерь больше, и точность меньше, а скорость выше только на 1 эпоху)  
    2. Одна из наибольших метрик точности в конце обучения (лучше только у комбинации contrast_factor = 2, delta = 0.1, но при такой комбинации потерь больше, и скорость схождения алгоритма ниже, а точность больше только на 0.02 процента)  
    3. Наименьшее значение потерь в конце обучения (значение потерь 0.2798)  
  + По сравнению с политикой без аугментации данных:
    1. Увеличилась скорость схождения алгоритма, по сравнению с политикой без аугментации данных (увеличение скорости на 6 эпох)  
    2. Увеличение точности в конце обучения, по сравнению с политикой без аугментации данных (увеличение точности на 0.76 процента)  
    3. Не удалось уменьшить значение потерь в конце обучения, по сравнению с политикой без аугментации данных (увеличение потерь на 0.0145) 
***
Таким образом, использование техники манипуляции с яркостью и контрастом  привело к улучшению сходимости алгоритма обучения и по скорости, и по точности, но не по значению потерь при оптимально подобранных параметрах, в сравнении с политикой без аугментации данных. 
### 2. Поворот изображения на случайный угол  
Для поворота изображения на случайный угол был добавлен следующий слой: 
```
rot_img = tf.keras.layers.experimental.preprocessing.RandomRotation(factor = 0.02, fill_mode = 'reflect')(inputs)
```
factor - параметр, определяющий нижнюю и верхнюю границу для вращения по и против часовой стрелки. В данном случае случайный угол вращения будет выбран из диапазона [-7.2, 7.2] градусов, так как 0.02 * 360 = 7.2, а -0.02 * 360 = -7.2 (положительные значения означают вращение против часовой стрелки, а отрицательные - по часовой стрелке)  
inputs - входное изображение (224x224x3).  
fill_mode - режим заполнения (reflect - входные данные расширяются за счет отражения около края последнего пикселя)  
### Нахождение оптимальных параметров для поворота изображения на случайный угол:  
Для нахождения оптимальных параметров, были проведены обучения с различными параметрами, такими как (factor - параметр, определяющий диапазон из которого будет случайно выбран угол поворота, fill_mode - режим заполнения, k - коэффициент наклона экспоненциальной кривой):  
+ factor = 0.0, 0.02, fill_mode = 'reflect', k = 0.5 
+ factor = 0.0, 0.02, k = 0.3  
+ factor = 0.02, k = 0.3  
+ factor = 0.02, k = 0.5  
+ factor = 0.02, k = 0.7    
+ factor = 0.05, k = 0.5  
+ factor = 0.0, 0.5, k = 0.3  
+ factor = 0.0, 0.125, k = 0.3  
#### В результате получили следующие графики в сравнении с политикой экспоненциального затухания с оптимальными параметрами initial_lrate = 0.01 и k = 0.3 без аугментации данных:  
+ График метрики точности для предобученной нейронной сети EfficientNet-B0 (поворот изображения на случайный угол) для валидационного набора данных :

![legend_accuracy_rotation](https://user-images.githubusercontent.com/59259102/112817225-dcd89480-908a-11eb-966d-2b33562331e8.png)  

<img src="./epoch_categorical_accuracy_rotation.svg">  

![legend_accuracy_rotation_0 5_0 125](https://user-images.githubusercontent.com/59259102/112817261-e661fc80-908a-11eb-848a-4b67feaada78.png)  


<img src="./epoch_categorical_accuracy_rotation_with_0.125_0.5.svg">    

* График функции потерь для предобученной нейронной сети EfficientNet-B0 (поворот изображения на случайный угол) для валидационного набора данных:  

![legend_loss_rotation](https://user-images.githubusercontent.com/59259102/112817371-072a5200-908b-11eb-99d5-26df9c4a6a3c.png)  

<img src="./epoch_loss_rotation.svg">  

![legend_loss_rotation_0 5_0 125](https://user-images.githubusercontent.com/59259102/112817440-1b6e4f00-908b-11eb-9066-990920a0ca9a.png)  


<img src="./epoch_loss_with_0.125_0.5.svg">  

* Анализ полученных результатов  
Исходя из полученных результатов в качестве оптимальных параметров можно использовать: factor = 0.02, k = 0.3 (factor - параметр, определяющий диапазон из которого будет случайно выбран угол поворота, k - коэффициент наклона экспоненциальной кривой).
  + По сравнению с другими использовавшимися комбинациями:
    1. Достаточно высокая скорость схождения алгоритма = 24 эпохи (не самая лучшая чем у других комбинации, но все же лучше чем без аугментации)  
    2. Наибольшее значение метрики точности в конце обучения (88.83 процента)  
    3. Небольшое значение потерь в конце обучения (значение потерь 0.2798, это хоть и не самое наименьшее значение, но все же лучше, чем без аугментации)  
  + По сравнению с политикой без аугментации данных:  
    1. Увеличилась скорость схождения алгоритма, по сравнению с политикой без аугментации данных (увеличение скорости на 8 эпох)  
    2. Не удалось увеличить значение точности в конце обучения, по сравнению с политикой без аугментации данных (уменьшение точности на 0.34 процента)  
    3. Уменьшение значение потерь в конце обучения, по сравнению с политикой без аугментации данных (уменьшение потерь на 0.0027)
***
Таким образом, использование техники поворота изображения на случайный угол привело к улучшению сходимости алгоритма обучения и по скорости, и по значению потерь, но не по точности при оптимально подобранных параметрах, в сравнении с политикой без аугментации данных. Более того, можно заметить, что качество ухудшается тем больше, чем больше максимальный угол поворота изображения. 
### Влияние режимов заполнения для поворота изображения на случайный угол  
Режим заполнения настраивается с помощью параметра fill_mode, при этом параметр factor = 0.02 был выбран как самый оптимальный (factor - параметр, определяющий диапазон из которого будет случайно выбран угол поворота):
+ fill_mode = 'nearest'  
+ fill_mode = 'constant'  
+ fill_mode = 'wrap'  
+ fill_mode = 'reflect'  
### В результате получили следующие графики в сравнении с поворотом изображения на случайный угол без использования режимов заполнения:  
+ График метрики точности для предобученной нейронной сети EfficientNet-B0 (влияние режимов заполнения) для валидационного набора данных:

![изображение](https://user-images.githubusercontent.com/59259102/112891622-06240f80-90e1-11eb-91d9-5defaf85b56a.png)   

<img src="./epoch_categorical_accuracy_fill_mode.svg">

* График функции потерь для предобученной нейронной сети EfficientNet-B0 (влияние режимов заполнения) для валидационного набора данных:  

![изображение](https://user-images.githubusercontent.com/59259102/112891679-176d1c00-90e1-11eb-8c44-29a1e4497b66.png)  


<img src="./epoch_loss_fill_mode.svg">  

* Анализ полученных результатов  
Исходя из полученных результатов, можно сделать вывод, что только один из режимов заполнения, а именно reflect, привел к увеличению значения точности в конце обучения (точность выше на 0.08 процента), но в то же время, скорость схождения алгоритма меньше на 5 эпох и потерь больше на 0.0099 по сравнению с поворотом изображения на случайный угол без использования режимов заполнения. Все остальные режимы заполнения (wrap, constant, nearest) привели к уменьшению значения точности и увеличению значения потерь.  
Таким образом оптимальными параметрами для поворота изображения на случайный угол будем считать factor = 0.02 (factor - параметр, определяющий диапазон из которого будет случайно выбран угол поворота) без использования режимов заполнения.  

### 3. Использование случайной части изображения  
Для использования случайной части изображения были добавлены следующие слои:  
```
x = tf.keras.layers.experimental.preprocessing.Resizing(height = 235, width = 235)(inputs)  
x = tf.keras.layers.experimental.preprocessing.RandomCrop(height = 224, width = 224)(x)  
```
Первый слой ``Resizing`` необходим для того, чтобы масштабировать наше изображение (224x224) до больших размеров (235x235). А затем к этому масштабированному изображению применяется слой ```RandomCrop``` для обрезки случайной части размером 224x224 из масштабированного изображения размером 235x235.  
Так как нейронная сеть EfficientNet-B0 требует подавать на вход изображение размером 224x224, то в данном случае параметры ```RandomCrop``` меняться не будут, а будут меняться параметры для ```Resizing``` (масштабирование), а именно высота (height) и ширина (width), которые будут у выходного изображения после применения этого слоя:  
+ height = 448, width = 448  
+ height = 300, width = 300  
+ height = 275, width = 275  
+ height = 250, width = 250  
+ height = 235, width = 235  
#### В результате получили следующие графики в сравнении с политикой экспоненциального затухания с оптимальными параметрами initial_lrate = 0.01 и k = 0.3 без аугментации данных:  
+ График метрики точности для предобученной нейронной сети EfficientNet-B0 (использование случайной части изображения) для валидационного набора данных:

![legend_accuracy_crop](https://user-images.githubusercontent.com/59259102/112820011-dac40500-908d-11eb-8585-9e9b5fd0eaef.png)  
 
<img src="./epoch_categorical_accuracy_crop.svg">

* График функции потерь для предобученной нейронной сети EfficientNet-B0 (использование случайной части изображения) для валидационного набора данных:  

![legend_loss_crop](https://user-images.githubusercontent.com/59259102/112820029-df88b900-908d-11eb-8baf-fdf6a3dc2287.png)  

<img src="./epoch_loss_crop.svg">

* Анализ полученных результатов 
Исходя из полученных результатов в качестве оптимальных параметров можно использовать: height = 235, width = 235 (высота (height) и ширина (width), которые будут у выходного изображения после применения слоя ```Resizing``` для масштабирования).
  + По сравнению с другими использовавшимися комбинациями:
    1. Одна из наибыстрейших скоростей схождения алгоритма = 24 эпохи (лучше только у  height = 448, width = 448, но при таких комбинациях потерь больше, и точность меньше)    
    2. Наибольшее значение метрики точности в конце обучения (88.73 процента)  
    3. Одно из наименьших значений потерь в конце обучения = 0.2993 (меньше только у height = 300, width = 300, но при такой комбинации точность ниже и скорость меньше)  
  + По сравнению с политикой без аугментации данных:  
    1. Увеличилась скорость схождения алгоритма, по сравнению с политикой без аугментации данных (увеличение скорости на 8 эпох)  
    2. Не удалось увеличить значение точности в конце обучения, по сравнению с политикой без аугментации данных (уменьшение точности на 0.44 процента)  
    3. Не удалось уменьшить значение потерь в конце обучения, по сравнению с политикой без аугментации данных (увеличение потерь на 0.034)  
***
Таким образом, техника использования случайной части изображения привела к улучшению сходимости алгоритма обучения только по скорости, но не по точности и не по значению потерь при оптимально подобранных параметрах, в сравнении с политикой без аугментации данных. Более того, можно заметить, что качество ухудшается тем больше, чем больше масштабируется изображение перед тем как его обрезать.   
### 4. Добавление случайного шума  
Для добавления случайного шума к изображению, был добавлен следующий слой: 
```
x = tf.keras.layers.GaussianNoise(stddev = 0.6)(inputs)  
```
inputs - входное изображение (224x224)  
stddev - значение среднеквадратичного отклонения добавляемого шума
### Нахождение оптимальных параметров для добавления случайного шума:  
Для нахождения оптимальных параметров, были проведены обучения с различными параметрами, такими как (stddev - значение среднеквадратичного отклонения добавляемого шума):  
+ stddev = 0.1  
+ stddev = 0.3  
+ stddev = 0.6  
+ stddev = 1.0  
+ stddev = 1.3  
#### В результате получили следующие графики в сравнении с политикой экспоненциального затухания с оптимальными параметрами initial_lrate = 0.01 и k = 0.3 без аугментации данных:  
+ График метрики точности для предобученной нейронной сети EfficientNet-B0 (добавление случайного шума) для валидационного набора данных:

![legend_accuracy_gauss](https://user-images.githubusercontent.com/59259102/112821189-0e535f00-908f-11eb-9f4e-0694c5a0f4da.jpg)  

<img src="./epoch_categorical_accuracy_gauss.svg">  

* График функции потерь для предобученной нейронной сети EfficientNet-B0 (добавление случайного шума) для валидационного набора данных:  

![legend_loss_gauss](https://user-images.githubusercontent.com/59259102/112821210-13181300-908f-11eb-8528-7909b1c252d8.jpg)  

<img src="./epoch_loss_gauss.svg">  

* Анализ полученных результатов  
Исходя из полученных результатов в качестве оптимальных параметров можно использовать: stddev = 0.6 (stddev - значение среднеквадратичного отклонения добавляемого шума).
  + По сравнению с другими использовавшимися комбинациями:
    1. Одна из наибыстрейших скоростей схождения алгоритма (лучше только у  stddev = 0.3 и stddev = 1.3, но при таких комбинациях потерь больше, и точность меньше)    
    2. Наибольшее значение метрики точности в конце обучения (89.72 процента)  
    3. Наименьшее значение потерь в конце обучения (значение потерь 0.2898)  
  + По сравнению с политикой без аугментации данных:  
    1. Увеличилась скорость схождения алгоритма, по сравнению с политикой без аугментации данных (увеличение скорости на 5 эпох)  
    2. Увеличение точности в конце обучения, по сравнению с политикой без аугментации данных (увеличение точности на 0.55 процента)  
    3. Не удалось уменьшить значение потерь в конце обучения, по сравнению с политикой без аугментации данных (увеличение потерь на 0.0245)  
***
Таким образом, использование техники добавления случайного шума привело к улучшению сходимости алгоритма обучения и по скорости, и по точности, но не по значению потерь при оптимально подобранных параметрах, в сравнении с политикой без аугментации данных. 
## Использование исследованных техник аугментации данных совместно  
В данной части лабораторной работы были использованы все вышеперечисленные техники аугментации данных совместно. Для каждой техники были использованы оптимальные параметры, а именно:
+ Манипуляции с яркостью и контрастом
  + contrast_factor = 2, delta = 0.3  
+ Поворот изображения на случайный угол 
  + factor = 0.02, k = 0.3 
+ Использование случайной части изображения  
  + height = 235, width = 235
+ Добавление случайного шума  
  + stddev = 0.6 
+ Политика экспоненциального затухания с оптимальными параметрами initial_lrate = 0.01 и k = 0.3 (initial_lrate - начальный темп обучения, k - коэффициент наклона экспоненциальной кривой).  
#### В результате получили следующие графики в сравнении с политикой экспоненциального затухания с оптимальными параметрами initial_lrate = 0.01 и k = 0.3 без аугментации данных:  
+ График метрики точности для предобученной нейронной сети EfficientNet-B0 (использование исследованных техник аугментации данных совместно) для валидационного набора данных:

![legend_accuracy_all](https://user-images.githubusercontent.com/59259102/112822047-165fce80-9090-11eb-9dd5-d8ee17bda2cf.png)


<img src="./epoch_categorical_accuracy_all.svg">  

* График функции потерь для предобученной нейронной сети EfficientNet-B0 (использование исследованных техник аугментации данных совместно) для валидационного набора данных:  

![legend_loss_all](https://user-images.githubusercontent.com/59259102/112822084-21b2fa00-9090-11eb-82ab-036c50b1be24.png)  
 
<img src="./epoch_loss_all.svg">  

* Анализ полученных результатов  
Исходя из полученных результатов можно отметить следующее:  
  + Совместное применение техник аугментации данных (манипуляция с яркостью и контрастом, поворот изображения на случайный угол, использование случайной части изображения, добавление случайного шума) с оптимальными параметрами для каждой техники, позволило улучшить обучение нейронной сети на валидационном наборе данных, а именно:  
    1. Увеличилась скорость схождения алгоритма, по сравнению с политикой без аугментации данных (увеличение скорости на 12 эпох)  
    2. Увеличение точности в конце обучения, по сравнению с политикой без аугментации данных (увеличение точности на 0.15 процента)  
    3. Уменьшение значения потерь в конце обучения, по сравнению с политикой без аугментации данных (уменьшение значения потерь на 0.0208)  
  + Таким образом, совместное использование техник аугментации данных привело к улучшению сходимости алгоритма обучения и по скорости, и по точности, и по значению потерь при оптимально подобранных параметрах для каждой техники, в сравнении с политикой без аугментации данных.  
