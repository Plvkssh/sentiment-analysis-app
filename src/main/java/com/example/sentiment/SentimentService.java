package com.example.sentiment;

import org.springframework.stereotype.Service;

@Service
public class SentimentService {

    public String classify(String text) {
        String t = text.toLowerCase();

        boolean positive = t.contains("good") || t.contains("great") || t.contains("love") || t.contains("awesome");
        boolean negative = t.contains("bad") || t.contains("hate") || t.contains("terrible") || t.contains("awful");

        if (positive && !negative) return "positive";
        if (negative && !positive) return "negative";
        return "neutral";
    }
}
