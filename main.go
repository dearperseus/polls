package main

import (
	"fmt"
	"math/rand"
	"time"
)

func main() {
	rand.Seed(time.Now().UnixNano())

	var minX, minY float32 = 55.672490, 37.534243

	var MoscowSize float32 = 0.2

	x := rand.Float32()*MoscowSize + minX
	y := rand.Float32()*MoscowSize + minY

	for i := 0; i < 1; i++ {

		fmt.Printf("1111111 %2.6f\n", x)
		fmt.Printf("1111111 %2.6f\n", y)
	}
}
