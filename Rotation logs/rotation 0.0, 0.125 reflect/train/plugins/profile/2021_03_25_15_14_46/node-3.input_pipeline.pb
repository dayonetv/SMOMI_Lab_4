  *????Ұ?@P??nR??@)      p=2?
{Iterator::Model::MaxIntraOpParallelism::FiniteTake::Prefetch::BatchV2::MemoryCacheImpl::ParallelMapV2::FlatMap[0]::TFRecord??h>g@!g????RM@)??h>g@1g????RM@:Advanced file read2|
EIterator::Model::MaxIntraOpParallelism::FiniteTake::Prefetch::BatchV2?s'??@!?00tH/D@)Uܸ??<@1(w&?	?C@:Preprocessing2?
VIterator::Model::MaxIntraOpParallelism::FiniteTake::Prefetch::BatchV2::MemoryCacheImpl?.Ȗ??!=?(ѻ???)?<Y????1??+????:Preprocessing2?
eIterator::Model::MaxIntraOpParallelism::FiniteTake::Prefetch::BatchV2::MemoryCacheImpl::ParallelMapV2???G??!?4J?+??)???G??1?4J?+??:Preprocessing2?
nIterator::Model::MaxIntraOpParallelism::FiniteTake::Prefetch::BatchV2::MemoryCacheImpl::ParallelMapV2::FlatMapNG 7??@!lr??|?M@)r??rg&??11?JU?J??:Preprocessing2s
<Iterator::Model::MaxIntraOpParallelism::FiniteTake::Prefetch???????!?&ſ??)???????1?&ſ??:Preprocessing2i
2Iterator::Model::MaxIntraOpParallelism::FiniteTake??mnLO??!w??v??)?I?>͙?1/?*?????:Preprocessing2?
RIterator::Model::MaxIntraOpParallelism::FiniteTake::Prefetch::BatchV2::MemoryCache???Mb??!f.7?G??)?????̓?1Iu????:Preprocessing2F
Iterator::Model??s]???!Y>Wϳ???)??)????1%B+"?	??:Preprocessing2]
&Iterator::Model::MaxIntraOpParallelismk???T??!??u???).?&??1J?9?w&??:Preprocessing:?
]Enqueuing data: you may want to combine small input data chunks into fewer but larger chunks.
?Data preprocessing: you may increase num_parallel_calls in <a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#map" target="_blank">Dataset map()</a> or preprocess the data OFFLINE.
?Reading data from files in advance: you may tune parameters in the following tf.data API (<a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#prefetch" target="_blank">prefetch size</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#interleave" target="_blank">interleave cycle_length</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/TFRecordDataset#class_tfrecorddataset" target="_blank">reader buffer_size</a>)
?Reading data from files on demand: you should read data IN ADVANCE using the following tf.data API (<a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#prefetch" target="_blank">prefetch</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#interleave" target="_blank">interleave</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/TFRecordDataset#class_tfrecorddataset" target="_blank">reader buffer</a>)
?Other data reading or processing: you may consider using the <a href="https://www.tensorflow.org/programmers_guide/datasets" target="_blank">tf.data API</a> (if you are not using it now)?
:type.googleapis.com/tensorflow.profiler.BottleneckAnalysisk
unknownTNo step time measured. Therefore we cannot tell where the performance bottleneck is.no*noZno#You may skip the rest of this page.BZ
@type.googleapis.com/tensorflow.profiler.GenericStepTimeBreakdown
  " * 2 : B J R Z b JGPUb??No step marker observed and hence the step time is unknown. This may happen if (1) training steps are not instrumented (e.g., if you are not using Keras) or (2) the profiling duration is shorter than the step time. For (1), you need to add step instrumentation; for (2), you may try to profile longer.