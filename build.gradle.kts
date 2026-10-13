plugins {
    java
    application
}

group = "com.burnsy.samples"
version = "0.1.0"

java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(21))
    }
}

application {
    mainClass.set("sample.App")
}

tasks.jar {
    manifest {
        attributes["Main-Class"] = "sample.App"
    }
}
