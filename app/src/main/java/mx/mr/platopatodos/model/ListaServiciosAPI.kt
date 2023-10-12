package mx.mr.platopatodos.model

import mx.mr.platopatodos.model.requests.IncidentReq
import mx.mr.platopatodos.model.requests.LoginReq
import mx.mr.platopatodos.model.requests.MenuReq
import mx.mr.platopatodos.model.responses.LoginRes
import mx.mr.platopatodos.model.responses.StringResponse
import retrofit2.Call
import retrofit2.http.Body
import retrofit2.http.Headers
import retrofit2.http.POST

interface ListaServiciosAPI {

    @Headers("Content-Type: application/json")
    @POST("loginEncargado")
    fun userLogin(@Body info: LoginReq): Call<LoginRes>

    @Headers("Content-Type: application/json")
    @POST("insertaMenu")
    fun uploadMenu(@Body menu: MenuReq): Call<StringResponse>

    @Headers("Content-Type: application/json")
    @POST("insertaIncidencia")
    fun uploadIncidence(@Body incident: IncidentReq): Call<StringResponse>

}