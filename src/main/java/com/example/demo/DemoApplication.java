package com.example.demo;

import com.microsoft.azure.functions.ExecutionContext;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.util.function.Function;

@SpringBootApplication
public class DemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }

    @Bean
    public Function<String, String> reverse(ExecutionContext context) {
        return value -> {
            context.getLogger().info("Reversing String - " + value);
            return new StringBuilder(value).toString();
        };
    }

}
