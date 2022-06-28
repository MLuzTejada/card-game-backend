# Card game: "UNO" - Backend

Api for the card game "UNO".

This api only manages the dynamics of the board. Doesn't manage the rules of the game.

## Run Locally

Clone the project

```bash
  git clone https://github.com/MLuzTejada/card-game-backend.git
```

Go to the project directory

```bash
  cd card-game-backend
```

Install dependencies

```bash
bundle install
```

Start the server

```bash
  rails s -b 'ssl://localhost:3000?cert=config/local-certs/localhost.pem&key=config/local-certs/localhost-key.pem&verify_mode=none'
```

## Troubleshooting

#### Error with certificate

Start the server

```bash
  rails s -b 'ssl://localhost:3000?cert=config/local-certs/localhost.pem&key=config/local-certs/localhost-key.pem&verify_mode=none'
```

Go to

```bash
  https://localhost:3000/
```

type

```bash
  thisisunsafe
```

## API Reference

#### Register

  ##### Request
  
  ```http
    POST player/register
  ```

  | Body | Type     | Description                |
  | :-------- |  :------- | :------------------------- |
  | `username` | `string` | **Required**. user name to register |
  | `password` | `string` | **Required**. Password to register |


  ##### Request example
  ```
  curl --location --request POST 'https://localhost:3000/player/register' \
--header 'Content-Type: application/json' \
--data-raw '{
    "username": "pepe",
    "password": "pepehonguito18"
}'
  ```

  ##### Sucess Response

  ```
  {
    "id": 3,
    "username": "pepe",
    "password": "pepehonguito18",
    "email": null,
    "phone": null,
    "cards": [],
    "uno": false,
    "token": "6460b587-45d7-4c48-90bf-198cb953e922",
    "created_at": "2022-06-28T00:14:42.819Z",
    "updated_at": "2022-06-28T00:14:42.819Z"
}
  ```

  ##### Error Response
  ```
  {
    "username": [
        "can't be blank"
    ],
    "password": [
        "La contraseña debe cumplir con el formato"
    ]
}
  ```


#### Log in

##### Request

```http
  POST player/login
```

  | Body | Type     | Description                |
  | :-------- |  :------- | :------------------------- |
  | `username` | `string` | **Required**. user name to register |
  | `password` | `string` | **Required**. Password to register |


##### Request example
```
curl --location --request POST 'https://localhost:3000/player/login' \
--header 'Content-Type: application/json' \
--header 'Cookie: player_id=3' \
--data-raw '{
    "username": "pepe",
    "password": "pepehonguito18"
}'
```

  ##### Sucess Response

  ```
  {
    "id": 3,
    "username": "pepe",
    "password": "pepehonguito18",
    "email": null,
    "phone": null,
    "cards": [],
    "uno": false,
    "token": "6460b587-45d7-4c48-90bf-198cb953e922",
    "created_at": "2022-06-28T00:14:42.819Z",
    "updated_at": "2022-06-28T00:14:42.819Z"
}
  ```

  ##### Error Response
  ```
  {
    "message": "Jugador no encontrado"
}
  ```


#### Log out
##### Request

```http
  GET player/logout/:id
```

| Headers | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `Authorization`      | `string` | **Required**. Your API token|
| `Cookie`      | `string` | **Required**. Keeps track of the player session|

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `id` | `string` | **Required**. Id of the player to logout|

##### Request example
```
curl --location --request GET 'https://localhost:3000/player/logout/3' \
--header 'Authorization: 6460b587-45d7-4c48-90bf-198cb953e922' \
--header 'Cookie: player_id=3'
```

  ##### Sucess Response

  ```
  {
    "message": "Cerro sesion satisfactoriamente"
  }
  ```

  ##### Error Response
  ```
  {
    "message": "Jugador no autorizado"
}
  ```

#### Create or join to a game
##### Request

```http
  POST /game
```

| Headers | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `Authorization` | `string` | **Required**. Your API token |
| `Cookie`      | `string` | **Required**. Keeps track of the player session|

| Body | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `id` | `integer` | **Required**. Id of the player who creates or join to the game|
| `roomCode` | `string or null` | **Required**. Code of the game|

##### Request example: create a game
```
curl --location --request POST 'https://localhost:3000/game' \
--header 'Authorization: 6460b587-45d7-4c48-90bf-198cb953e922' \
--header 'Content-Type: application/json' \
--header 'Cookie: player_id=3' \
--data-raw '{
    "id": 3,
    "roomCode": null
}'
```

##### Request example: join a game
```
curl --location --request POST 'https://localhost:3000/game' \
--header 'Authorization: 11523845-a749-4d3f-bbed-2381c70ba63d' \
--header 'Content-Type: application/json' \
--header 'Cookie: player_id=4' \
--data-raw '{
    "id": 4,
    "roomCode": "ee0449a369040ef28bd5"
}'
```

##### Sucess Response

  ```
  {
    "message": "Se creo a la partida exitosamente",
    "game": {
        "id": 1,
        "roomCode": "ee0449a369040ef28bd5",
        "current_card": "3Y",
        "created_at": "2022-06-28T00:27:26.780Z",
        "updated_at": "2022-06-28T00:27:26.780Z"
    }
}
  ```


  ```
  {
    "message": "Se unio a la partida exitosamente",
    "game": {
        "id": 1,
        "roomCode": "ee0449a369040ef28bd5",
        "current_card": "3Y",
        "created_at": "2022-06-28T00:27:26.780Z",
        "updated_at": "2022-06-28T00:27:26.780Z"
    },
    "players": [
        {
            "id": 3,
            "username": "pepe",
            "password": "pepehonguito18",
            "email": null,
            "phone": null,
            "cards": [],
            "uno": false,
            "token": "6460b587-45d7-4c48-90bf-198cb953e922",
            "created_at": "2022-06-28T00:14:42.819Z",
            "updated_at": "2022-06-28T00:14:42.819Z"
        },
        {
            "id": 4,
            "username": "marialuz",
            "password": "mari1998",
            "email": null,
            "phone": null,
            "cards": [],
            "uno": false,
            "token": "11523845-a749-4d3f-bbed-2381c70ba63d",
            "created_at": "2022-06-28T01:54:28.227Z",
            "updated_at": "2022-06-28T01:54:28.227Z"
        }
    ]
}
  ```

  ##### Error Response
  ```
  {
    "message": "Jugador no autorizado"
}
  ```

  ```
    {
    "message": "Hubo un error creando la partida"
},
{
    error: {
        errors
    }
}
  ```

#### Move a card
##### Request

```http
  POST /move
```

| Headers | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `Authorization` | `string` | **Required**. Your API token |
| `Cookie`      | `string` | **Required**. Keeps track of the player session|

| Body | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `id` | `integer` | **Required**. Id of the player who makes the move|
| `roomCode` | `string` | **Required**. Code of the game where the move is made|
| `card` | `integer` | **Required**. The card of the player who makes the move|

##### Request example
```
curl --location --request POST 'https://localhost:3000/move' \
--header 'Authorization: 11523845-a749-4d3f-bbed-2381c70ba63d' \
--header 'Content-Type: application/json' \
--header 'Cookie: player_id=4' \
--data-raw '{
    "id": 4,
    "roomCode": "ee0449a369040ef28bd5",
    "card": "5Y"
}'
```

##### Sucess Response

```
{
    "message": "Movimiento realizado con exito",
    "game": {
        "current_card": "5Y",
        "id": 1,
        "roomCode": "ee0449a369040ef28bd5",
        "created_at": "2022-06-28T00:27:26.780Z",
        "updated_at": "2022-06-28T02:00:56.046Z"
    },
    "player": {
        "id": 4,
        "username": "marialuz",
        "password": "mari1998",
        "email": null,
        "phone": null,
        "cards": [],
        "uno": false,
        "token": "11523845-a749-4d3f-bbed-2381c70ba63d",
        "created_at": "2022-06-28T01:54:28.227Z",
        "updated_at": "2022-06-28T01:54:28.227Z"
    }
}
```

##### Error Response
  ```
  {
  "message": "Movimiento invalido"
}
  ```

  ```
    {
    "message": "Ocurrió un error"
},
{
    error: {
        errors
    }
}
  ```
```
  {
  "message": "Jugador no autorizado"
}
```

#### Get a game by player id
##### Request

```http
  GET player/:id/getGame
```

| Headers | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `Authorization` | `string` | **Required**. Your API token |
| `Cookie`      | `string` | **Required**. Keeps track of the player session|

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `id` | `string` | **Required**. Id of the player you want to find the game|

##### Request example
```
curl --location --request GET 'https://localhost:3000/player/3/getGame' \
--header 'Authorization: 6460b587-45d7-4c48-90bf-198cb953e922' \
--header 'Cookie: player_id=3'
```

##### Sucess Response

  ```
  {
    "game": {
        "id": 1,
        "roomCode": "ee0449a369040ef28bd5",
        "current_card": "5Y",
        "created_at": "2022-06-28T00:27:26.780Z",
        "updated_at": "2022-06-28T02:00:56.046Z"
    },
    "players": [
        {
            "id": 3,
            "username": "pepe",
            "password": "pepehonguito18",
            "email": null,
            "phone": null,
            "cards": [],
            "uno": false,
            "token": "6460b587-45d7-4c48-90bf-198cb953e922",
            "created_at": "2022-06-28T00:14:42.819Z",
            "updated_at": "2022-06-28T00:14:42.819Z"
        },
        {
            "id": 4,
            "username": "marialuz",
            "password": "mari1998",
            "email": null,
            "phone": null,
            "cards": [],
            "uno": false,
            "token": "11523845-a749-4d3f-bbed-2381c70ba63d",
            "created_at": "2022-06-28T01:54:28.227Z",
            "updated_at": "2022-06-28T01:54:28.227Z"
        }
    ]
}
  ```

  ##### Error Response
  ```
  {
    "message": "Partida no encontrada"
  }
  ```

#### Get the current player from the session

##### Request

```http
  GET /players/current
```

| Headers | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `Cookie`      | `string` | **Required**. Keeps track of the player session|


##### Request example
```
curl --location --request GET 'https://localhost:3000/player/current' \
--header 'Cookie: player_id=3'
```

  ##### Sucess Response

  ```
  {
    "id": 3,
    "username": "pepe",
    "password": "pepehonguito18",
    "email": null,
    "phone": null,
    "cards": [],
    "uno": false,
    "token": "6460b587-45d7-4c48-90bf-198cb953e922",
    "created_at": "2022-06-28T00:14:42.819Z",
    "updated_at": "2022-06-28T00:14:42.819Z"
}
  ```

#### Update the data of a player

##### Request

```http
  PUT player/:id
```

| Headers | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `Authorization`      | `string` | **Required**. Your API token|
| `Cookie`      | `string` | **Required**. Keeps track of the player session|

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `id` | `string` | **Required**. Id of the player you want to update the data|

| Body | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `username` | `string` | **Required**. new value of the username|
| `email` | `string` | **Required**. new new value of the email |
| `phone` | `integer` | **Required**. new value of the phone|


##### Request example
```
curl --location --request PUT 'https://localhost:3000/player/3' \
--header 'Authorization: 6460b587-45d7-4c48-90bf-198cb953e922' \
--header 'Content-Type: application/json' \
--header 'Cookie: player_id=3' \
--data-raw '{
    "username": "pepe",
    "email": "pepe@gmail.com",
    "phone": "2619328637"
}'
```

  ##### Sucess Response

  ```
  {
    "username": "pepe",
    "email": "pepe@gmail.com",
    "phone": "2619328637",
    "id": 3,
    "password": "pepehonguito18",
    "cards": [],
    "uno": false,
    "token": "6460b587-45d7-4c48-90bf-198cb953e922",
    "created_at": "2022-06-28T00:14:42.819Z",
    "updated_at": "2022-06-28T02:14:39.354Z"
}
  ```

  ##### Error Response
  ```
  {
    errors
  }
  ```

  ```
  {
    "message": "Jugador no autorizado"
  }
  ```

#### Update the password of a player

##### Request

```http
  PUT player/:id/password
```

| Headers | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `Authorization`      | `string` | **Required**. Your API token|
| `Cookie`      | `string` | **Required**. Keeps track of the player session|

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `id` | `string` | **Required**. Id of the player you want to update the password|

| Body | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `password` | `string` | **Required**. new value of the password|


##### Request example
```
curl --location --request PUT 'https://localhost:3000/player/3/password' \
--header 'Authorization: 6460b587-45d7-4c48-90bf-198cb953e922' \
--header 'Content-Type: application/json' \
--header 'Cookie: player_id=3' \
--data-raw '{
    "password": "pepehonguito20"
}'
```

  ##### Sucess Response

  ```
  {
    "password": "pepehonguito20",
    "id": 3,
    "username": "pepe",
    "email": "pepe@gmail.com",
    "phone": "2619328637",
    "cards": [],
    "uno": false,
    "token": "6460b587-45d7-4c48-90bf-198cb953e922",
    "created_at": "2022-06-28T00:14:42.819Z",
    "updated_at": "2022-06-28T02:20:34.378Z"
}
  ```

  ##### Error Response
  ```
  {
    errors
  }
  ```

  ```
  {
    "message": "Jugador no autorizado"
  }
  ```

#### Set "UNO" to a player

##### Request

```http
 POST player/:id/setUno
```

| Headers | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `Authorization`      | `string` | **Required**. Your API token|
| `Cookie`      | `string` | **Required**. Keeps track of the player session|

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `id` | `string` | **Required**. Id of the player you want to set "UNO"|

##### Request example
```
curl --location --request POST 'https://localhost:3000/player/3/setUno' \
--header 'Authorization: 6460b587-45d7-4c48-90bf-198cb953e922' \
--header 'Cookie: player_id=3' \
--data-raw ''
```

  ##### Sucess Response

  ```
  {
    "message": "El jugador grito UNO"
  }
  ```

  ##### Error Response
  ```
  {
      errors
  }
  ```

  ```
  {
    "message": "Jugador no autorizado"
  }
  ```

#### Get one card for a player

##### Request

```http
 GET player/:id/getCard
```

| Headers | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `Authorization`      | `string` | **Required**. Your API token|
| `Cookie`      | `string` | **Required**. Keeps track of the player session|

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `id` | `string` | **Required**. Id of the player who wants the card|

##### Request example
```
curl --location --request GET 'https://localhost:3000/player/3/getCard' \
--header 'Authorization: 6460b587-45d7-4c48-90bf-198cb953e922' \
--header 'Cookie: player_id=3'
```

  ##### Sucess Response

  ```
  {
    "message": "Saco una carta satisfactoriamente",
    "player": {
        "id": 3,
        "username": "pepe",
        "password": "pepehonguito20",
        "email": "pepe@gmail.com",
        "phone": "2619328637",
        "cards": [
            "7R"
        ],
        "uno": true,
        "token": "6460b587-45d7-4c48-90bf-198cb953e922",
        "created_at": "2022-06-28T00:14:42.819Z",
        "updated_at": "2022-06-28T02:25:51.391Z"
    }
}
  ```

  ##### Error Response
  ```
  { 
      "message": "Ocurrio un error" , 
      player: errors 
    }
  ```

  ```
  {
    "message": "Jugador no autorizado"
  }
  ```

#### Get a deck of 7 cards for a player

##### Request

```http
 GET player/:id/getDeck
```

| Headers | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `Authorization`      | `string` | **Required**. Your API token|
| `Cookie`      | `string` | **Required**. Keeps track of the player session|

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `id` | `string` | **Required**. Id of the player who wants the deck|

##### Request example
```
curl --location --request GET 'https://localhost:3000/player/3/getDeck' \
--header 'Authorization: 6460b587-45d7-4c48-90bf-198cb953e922' \
--header 'Cookie: player_id=3'
```

  ##### Sucess Response

  ```
  {
    "message": "Repartio las cartas satisfactoriamente",
    "player": {
        "cards": [
            "D2G",
            "7B",
            "4Y",
            "skipG",
            "2G",
            "skipB",
            "3Y"
        ],
        "id": 3,
        "username": "pepe",
        "password": "pepehonguito20",
        "email": "pepe@gmail.com",
        "phone": "2619328637",
        "uno": true,
        "token": "6460b587-45d7-4c48-90bf-198cb953e922",
        "created_at": "2022-06-28T00:14:42.819Z",
        "updated_at": "2022-06-28T02:28:50.033Z"
    }
}
  ```

  ##### Error Response
  ```
    { 
      "message": "Ocurrio un error" , 
      player: errors 
    }
  ```

  ```
  {
    "message": "Jugador no autorizado"
  }
  ```

## Authors

- [@MLuzTejada](https://github.com/MLuzTejada)

