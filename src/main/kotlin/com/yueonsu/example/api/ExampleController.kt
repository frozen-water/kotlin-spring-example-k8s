package com.yueonsu.example.api

import org.springframework.beans.factory.annotation.Value
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping(value = ["/example"])
class ExampleController(
    @Value("\${environment}") private val environment: String
) {

    @GetMapping
    fun example(): String {
        return "env == $environment"
    }
}