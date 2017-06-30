package com.wirecard.cicg.hackday.kafka;

import com.wirecard.cicg.hackday.kafka.io.JsonSerializer;
import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.Producer;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.common.serialization.StringDeserializer;
import org.apache.kafka.common.serialization.StringSerializer;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Properties;
import java.util.UUID;

import static java.util.Collections.singletonList;

@Configuration
public class KafkaConfig {

    @Value("${read.from.start:false}")
    private boolean readFromStart;

    @Bean
    public KafkaConsumer kafkaConsumer(){
        KafkaConsumer<String, String> consumer = new KafkaConsumer<>(kafkaProperties());
        consumer.subscribe(singletonList("test"));
        return consumer;
    }

    @Bean
    public Properties kafkaProperties() {
        Properties props = new Properties();
        props.put(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, "localhost:9092");
        if (readFromStart) {
            props.put(ConsumerConfig.GROUP_ID_CONFIG, UUID.randomUUID().toString());
            props.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest");
        } else {
            props.put(ConsumerConfig.GROUP_ID_CONFIG, "default");
        }
        props.put(ConsumerConfig.ENABLE_AUTO_COMMIT_CONFIG, true);
        props.put(ConsumerConfig.AUTO_COMMIT_INTERVAL_MS_CONFIG, "100");
        props.put(ConsumerConfig.SESSION_TIMEOUT_MS_CONFIG, "15000");
        props.put(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class);
        props.put(ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class);
        return props;
    }

    @Bean
    public Properties kafkaProducerProperties() {
        Properties props = new Properties();
        props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, "localhost:9092");
        props.put(ProducerConfig.ACKS_CONFIG, "all");
        props.put(ProducerConfig.RETRIES_CONFIG, 2);
        props.put(ProducerConfig.BATCH_SIZE_CONFIG, 16384);
        props.put(ProducerConfig.LINGER_MS_CONFIG, 1);
        props.put(ProducerConfig.BUFFER_MEMORY_CONFIG, 33554432);
        props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class);
        props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, JsonSerializer.class);
        return props;
    }

    @Bean
    public Producer<String, Object> kafkaProducer() {
        return new KafkaProducer<>(kafkaProducerProperties());
    }
}
