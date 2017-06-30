package com.wirecard.cicg.hackday.kafka.io;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.kafka.common.serialization.Serializer;

import java.io.IOException;
import java.io.StringWriter;
import java.util.Map;

public class JsonSerializer implements Serializer<Object> {

    private final static String ENCODING = "UTF8";
    private final ObjectMapper mapper = new ObjectMapper();

    @Override
    public void configure(Map<String, ?> configs, boolean isKey) {

    }

    @Override
    public byte[] serialize(String topic, Object data) {
        StringWriter stringEmp = new StringWriter();
        try {
            mapper.writeValue(stringEmp, data);
            return stringEmp.toString().getBytes(ENCODING);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void close() {

    }
}
