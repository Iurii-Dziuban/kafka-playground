package com.wirecard.cicg.hackday.kafka.io;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.kafka.common.serialization.Deserializer;
import org.apache.log4j.Logger;

import java.io.IOException;
import java.util.Collections;
import java.util.Map;

public class JsonDeserializer implements Deserializer<Map<String, Object>> {

    private static final Logger LOG = Logger.getLogger(JsonDeserializer.class);
    private final ObjectMapper mapper = new ObjectMapper();

    @Override
    public void configure(Map<String, ?> configs, boolean isKey) {

    }

    @Override
    public Map<String, Object> deserialize(String topic, byte[] data) {
        try {
            return (Map<String, Object>) mapper.readValue(data, Map.class);
        } catch (IOException e) {
            LOG.error("Error reading object: " + new String(data));
            return Collections.emptyMap();
        }
    }

    @Override
    public void close() {

    }
}
