/**
    Author: Neet🍣#1072 Discord ID: 302249242469335060
        Descripcion: Ejemplo de como hacer una rutas con checkpoints
    Curso de Pawn en Español: https://www.youtube.com/watch?v=74OMBVHIyzY&list=PLCI6CxS9c2WH-Pb3p1hnAgKChcqC9Ifyb
 */
#include <a_samp>
#include <zcmd> 
#define MAX_SCORED 3 // checkpoints necesarios para terminar el recorrido
new PlayerScore[MAX_PLAYERS]; //puntuaje de inicio del jugador
new Float:CheckPointsPos[3][3] = {
    {138.1951,-72.8674,1.4297}, // 1 checkpoint
    {162.4014,-72.4193,1.4297}, // 2 checkpoint
    {192.5101,-71.6351,1.4330}  // 3 checkpoint
};
DefaultPlayerPos(playerid){
    SetCameraBehindPlayer(playerid);
    SetPlayerInterior(playerid, 0);
    SetPlayerPos(playerid,132.4555,-69.4521,1.5781);
    SetPlayerFacingAngle(playerid, 240.0156);
}
SetCheckpoints(playerid, score){
    switch(score) {
        case 1: SetPlayerCheckpoint(playerid, CheckPointsPos[0][0], CheckPointsPos[0][1],CheckPointsPos[0][2], 3.0);//checkpoint 1
        case 2: SetPlayerCheckpoint(playerid, CheckPointsPos[1][0], CheckPointsPos[1][1],CheckPointsPos[1][2], 3.0);//checkpoint 2
        case 3: SetPlayerCheckpoint(playerid, CheckPointsPos[2][0], CheckPointsPos[2][1],CheckPointsPos[2][2], 3.0);//checkpoint 3
        default: return 1;
    }
    return 1;
}
//funcion que se ejecuta cuando el jugador entra en un checkpoint
PlayerGotCheckpoint(playerid, score){
    DisablePlayerCheckpoint(playerid); //quita el checkpoint
    if(score == MAX_SCORED){
        SendClientMessage(playerid, -1, "Terminaste el recorrido!");
        DefaultPlayerPos(playerid);
    }
    else {
        SendClientMessage(playerid, -1, "Has alcanzado un checkpoint");
        SetCheckpoints(playerid, ++PlayerScore[playerid]);
    }
    return 1;
}
//posicion iniclal del jugador
//comando /prueba
CMD:prueba(playerid){
    DefaultPlayerPos(playerid);
    if(PlayerScore[playerid] != 1 || PlayerScore[playerid] == 3){ 
        //por si el jugador quiere iniciar de nuevo 
        DisablePlayerCheckpoint(playerid);
        PlayerScore[playerid] = 1;
        SetCheckpoints(playerid, PlayerScore[playerid]);
        SendClientMessage(playerid, -1,"Comienza a recorrer nuevamente");
    }
    else {
        //comienza a recorrer
        SetCheckpoints(playerid, PlayerScore[playerid]);
        SendClientMessage(playerid, -1,"Comienza a recorrer");
    }
    return 1;
}

public OnPlayerConnect(playerid){
	PlayerScore[playerid] = 1;
    return 1;
}
public OnPlayerSpawn(playerid){
    DefaultPlayerPos(playerid);
    return 1;
}
public OnPlayerEnterCheckpoint(playerid) {
    PlayerGotCheckpoint(playerid, PlayerScore[playerid]);
    return 1;
}
main(){ printf("servidor corriendo...");}