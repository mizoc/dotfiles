package main

import (
	"github.com/rivo/tview"
	"os/exec"
)

func main() {
	app := tview.NewApplication()
	modal := tview.NewModal().
		SetText(` Thank you for downloading
    ____ ___  (_)___  ____  _____
   / __ __ \/ /_  / / __ \/ ___/
  / / / / / / / / /_/ /_/ / /__
 /_/ /_/ /_/_/ /___/\____/\___/`).
		AddButtons([]string{"Install", "Cancel"}).
		SetDoneFunc(func(buttonIndex int, buttonLabel string) {
			if buttonLabel == "Install" {
				cmd := exec.Command("./install.sh")
				cmd.Start()
				cmd.Wait()
				app.Stop()
			}
			if buttonLabel == "Cancel" {
				app.Stop()
			}
		})
	if err := app.SetRoot(modal, false).Run(); err != nil {
		panic(err)
	}
}
