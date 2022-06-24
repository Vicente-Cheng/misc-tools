package main

/*
 * The most import thing here is that
 * use `Value` instead `DefaultText` for
 * default value.
 *
 * `DefaultText` is really for Text.
 *
 * If `DefaultText` is nil, it will take
 * `Value` for it
 *
 */

import (
	"fmt"
	"os"

	"github.com/urfave/cli/v2"
)

var defaultValue uint
var defaultValueText uint

func main() {
	app := cli.NewApp()
	app.Name = "Try Default"
	app.Usage = "Try Default"
	app.Action = printOut
	app.Flags = []cli.Flag{
		&cli.UintFlag{
			Name:        "defaultvalue",
			Usage:       "Value for default",
			Value:       5,
			DefaultText: "7", // really for text.
			Destination: &defaultValue,
		},
		&cli.UintFlag{
			Name:        "defaultvaluetext",
			Usage:       "DefaultText for default",
			DefaultText: "6",
			Destination: &defaultValueText,
		},
	}

	app.Run(os.Args)
}

func printOut(c *cli.Context) error {
	fmt.Println("defaultValue:", defaultValue)
	fmt.Println("defaultValueText:", defaultValueText)

	return nil
}
