package main

import (
	"github.com/rivo/tview"
	"os"
)

func main() {
	app := tview.NewApplication()
	modal := tview.NewModal().
		SetText(` Do you really want to UNINSTALL??

mizoc <https://github.com/mizoc/>
produced under MIT LICENCE`).
		AddButtons([]string{"Cancel", "UNINSTALL"}).
		SetDoneFunc(func(buttonIndex int, buttonLabel string) {
			if buttonLabel == "Cancel" {
				app.Stop()
				os.Exit(1)
			}
			if buttonLabel == "UNINSTALL" {
				app.Stop()
				os.Exit(0)
			}
		})
	if err := app.SetRoot(modal, false).Run(); err != nil {
		panic(err)
	}
}
