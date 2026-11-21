package com.codomax.awscloud.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class HealthController {

    @GetMapping("/api/status")
    public Map<String, String> status() {
        return Map.of(
                "application", "AWS IAM & EC2 Spring Boot Web Deployment",
                "status", "UP",
                "message", "The application is running successfully."
        );
    }
}
