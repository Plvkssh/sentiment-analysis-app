package com.example.sentiment;

import jakarta.validation.constraints.NotBlank;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.time.Instant;
import java.util.Map;

@Validated
@RestController
@RequestMapping("/api")
public class SentimentController {

    private final SentimentService sentimentService;

    public SentimentController(SentimentService sentimentService) {
        this.sentimentService = sentimentService;
    }

    @GetMapping("/sentiment")
    public Map<String, Object> sentiment(@RequestParam("text") @NotBlank String text) {
        String s = sentimentService.classify(text);
        return Map.of(
                "sentiment", s,
                "text", text,
                "timestamp", Instant.now().toString()
        );
    }

    @GetMapping("/healthz")
    public Map<String, Object> healthz() {
        return Map.of("status", "ok");
    }
}
