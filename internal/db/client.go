package db

import (
	"database/sql"
	_ "github.com/lib/pq"
	"log"
)

type Client interface {
	getConnection() *sql.DB
}

type store struct {
	connection *sql.DB
}

func NewClient() Client {
	db, err := sql.Open("postgres", "postgres://postgres:12345@pq_db:5432/postgres?sslmode=disable")
	if err != nil {
		log.Fatalln("Failed to connect to PostgreSQL", err)
	}

	if err := db.Ping(); err != nil {
		log.Fatalln("Error while pinging PostgreSQL DB", err)
	}

	return &store{
		connection: db,
	}
}

func (c *store) getConnection() *sql.DB {
	return c.connection
}
