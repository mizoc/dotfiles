package main

import (
	"github.com/rivo/tview"
	"os"
)

func main() {
	app := tview.NewApplication()
	modal := tview.NewModal().
		SetText(` Thank you for downloading
    ____ ___  (_)___  ____  _____
   / __ __ \/ /_  / / __ \/ ___/
  / / / / / / / / /_/ /_/ / /__
 /_/ /_/ /_/_/ /___/\____/\___/

mizoc <https://github.com/mizoc/>
produced under MIT LICENCE`).
		AddButtons([]string{"Install", "Cancel"}).
		SetDoneFunc(func(buttonIndex int, buttonLabel string) {
			if buttonLabel == "Install" {
				app.Stop()
				os.Exit(0)
			}
			if buttonLabel == "Cancel" {
				app.Stop()
				os.Exit(1)
			}
		})
	if err := app.SetRoot(modal, false).Run(); err != nil {
		panic(err)
	}
}
