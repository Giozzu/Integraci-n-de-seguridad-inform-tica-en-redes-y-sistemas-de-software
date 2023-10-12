package mx.mr.platopatodos.model

import com.google.gson.GsonBuilder
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

object RetrofitManager {

    private val retrofit: Retrofit by lazy {
        Retrofit.Builder()
            .baseUrl("http://3.95.129.111:8080/")
            .addConverterFactory(GsonConverterFactory.create(GsonBuilder().setLenient().create()))
            .build()
    }

    val apiService: ListaServiciosAPI by lazy {
        retrofit.create(ListaServiciosAPI::class.java)
    }
}