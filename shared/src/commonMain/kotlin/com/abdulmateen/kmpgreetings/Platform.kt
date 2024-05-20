package com.abdulmateen.kmpgreetings

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform