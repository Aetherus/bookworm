Bookworm
========

This is just a toy project to show in an job interview.

Bookworm is just another administration tool for the librarians.

## Models

  * The users of this system is the **librarians**
  * An **account** represents a customer who borrows books
  * A **loan** (why choose this word?) represents a transaction (borrowing/returning a book)

## API designing decisions

  * Follow the RESTful style as strict as possible
  * Favor _Single Source of Truth_ over performance (so you'll not see `accounts.balance` in database)

## How to run

The simpliest way of running this project is using Docker Compose.
Make sure the TCP ports 8080 and 3000 are not occupied, then

```
$ docker-compose up
```

And you are good to go. Try visit [http://localhost:8080/].

## API references

**Common rules**

  * All web APIs except the GET ones accept both application/json and application/x-www-form-urlencoded requests.
  * All web APIs provide JSON formatted responses.
  * All APIs except login requires a bearer token in the request headers as `Authorization: Bearer xxxxxx`, which can be acquired in the response of login requests.
  * CORS is supported, but credentials (cookies) are not allowed.
  * All timestamps should be formatted according to RFC 3339.
  * All monetary fields (fee, balance, etc.) are passed and returned as strings.

### Login

**POST /api/v1/sessions**

**Request body**

| Name | Type | Required | Remarks |
|------|------|----------|---------|
| email | string | yes ||
| password | string | yes | in cleartext |

**Response**

```
{
  "librarian": {
    "id": 1,
    "email": "jane-doe@example.com",
    "name": "Jane Doe"
  },
  "access_token": "Bearer xxxxxx"
}
```

### List Books

**GET /api/v1/books**

**Response**

```
[
  {
    "id": 1,
    "isbn": "978-1-68050-299-2",
    "title": "Programming Elixir 1.6",
    "author": "Dave Thomas",
    "published_on": "2018-05-17",
    "quantity": 42,
    "fee": "0.42"
  }
]
```

### Update the quantity of a book

**PATCH /api/v1/books/:id**

**Params**

| Name | Type | Required | Remarks |
|------|------|----------|---------|
| book[quantity] | integer | yes ||

**Response**

```
{
  "id": 1,
  "isbn": "978-1-68050-299-2",
  "title": "Programming Elixir 1.6",
  "author": "Dave Thomas",
  "published_on": "2018-05-17",
  "quantity": 142,
  "available_copies": 36
  "fee": "0.42"
}
```

### Get the detail of a book

**GET /api/v1/books/:id**

**Response**

```
{
  "id": 1,
  "isbn": "978-1-68050-299-2",
  "title": "Programming Elixir 1.6",
  "author": "Dave Thomas",
  "published_on": "2018-05-17",
  "quantity": 142,
  "available_copies": 36
  "fee": "0.42"
}
```

### Get all loans of a book in a given period of time

**GET /api/v1/books/:book\_id/loans**

**Params**

| Name | Type | Required | Remarks |
|------|------|----------|---------|
| from | timestamp | yes | the beginning of period to investigate |
| to | timestamp | yes | the end of period to investigate |

**Response**

```
[
  {
    "id": 1,
    "fee": "0.51",
    "created_at": "2020-03-10T11:32:16Z",
    "concluded_at": "2020-03-13T10:23:19Z"
    "account": {
      "id": 1,
      "number": "13430918401",
      "holder_name": "John Doe"
    }
  },
  ...
]
```

**Remarks**

  * If a loan is not concluded (the book is not returned yet), then the value of `concluded_at` field is `null`.

### List accounts

**GET /api/v1/accounts**

**Response**

```
[
  {
    "id": 1,
    "number": "13430918401",
    "holder_name": "John Doe"
  },
  ...
]
```

### Get account detail

**GET /api/v1/accounts/:id**

**Response**

```
{
  "id": 1,
  "number": "13430918401",
  "holder_name": "John Doe"
  "balance": "93.27",
  "loans": [
    {
      "id": 1,
      "fee": "0.51",
      "created_at": "2020-03-10T11:32:16Z",
      "concluded_at": "2020-03-13T10:23:19Z",
      "book": {
        "id": 1,
        "isbn": "978-1-68050-299-2",
        "title": "Programming Elixir 1.6",
        "author": "Dave Thomas",
        "published_on": "2018-05-17",
        "quantity": 142,
        "fee": "0.42"
      }
    },
    ...
  ]
}
```

**Remarks**

  * The fee of a loan can be different from the fee of the book because the fee of the book can have been changed since the loan.

### Create a loan

**POST /api/v1/loans**

**Params**

| Name | Type | Required | Remarks |
|------|------|----------|---------|
| loan[account_id] | integer | yes | who borrows the book |
| loan[book_id] | integer | yes | which book to borrow |

**Successful response**

```
{
  "id": 1,
  "fee": "0.51",
  "created_at": "2020-03-10T11:32:16Z",
  "account": {
    "id": 1,
    "number": "13430918401",
    "holder_name": "John Doe",
    "balance": "92.13"
  },
  "book": {
    "id": 1,
    "isbn": "978-1-68050-299-2",
    "title": "Programming Elixir 1.6",
    "author": "Dave Thomas",
    "published_on": "2018-05-17",
    "quantity": 142,
    "available_copies": 113,
    "fee": "0.42"
  }
}
```

**Error response (status 400)**

```
{
  "errors": {
    "fee": ["Exceeds balance"]
  }
}
```

or

```
{
  "errors": {
    "book_id": ["Unavailable"]
  }
}
```

## TODO

  * Pagination
  * Concurrency-safe account number generation mechanism
  * Full-text search on books

