package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"strconv"
	"strings"
)

type ColorCount struct {
	color string
	count int
}

func parseColors(s string) []ColorCount {
	r := make([]ColorCount, 0)
	for _, part := range strings.Split(s, ";") {
		for _, part1 := range strings.Split(part, ",") {
			split := strings.Split(strings.TrimSpace(part1), " ")
			count, err := strconv.Atoi(split[0])
			if err != nil {
				fmt.Println(split)
				log.Fatal(err)
			}
			c := ColorCount{count: count, color: split[1]}
			r = append(r, c)
		}
	}
	return r
}

type Game struct {
	id     int
	colors []ColorCount
}

func main() {
	file, err := os.Open(os.Args[1])
	if err != nil {
		log.Panic(err)
	}
	defer file.Close()
	data, err := ioutil.ReadAll(file)
	if err != nil {
		log.Panic(err)
	}

	lines := strings.Split(string(data), "\n")
	games := make([]Game, 0)
	for _, line := range lines {
		split := strings.Split(line, ":")
		game := Game{}
		id, _ := strconv.Atoi(strings.ReplaceAll(split[0], "Game ", ""))
		game.id = id
		game.colors = parseColors(strings.TrimSpace(split[1]))
		games = append(games, game)
	}
	count := 0
	for _, game := range games {
		ok := true
		for _, color := range game.colors {
			switch color.color {
			case "red":
				ok = ok && color.count <= 12
			case "green":
				ok = ok && color.count <= 13
			case "blue":
				ok = ok && color.count <= 14
			}
			if !ok {
				break
			}
		}
		if ok {
			count += game.id
		}
	}
	fmt.Print(count)
}
