import {render, screen} from "@testing-library/svelte"
import Hero from "./Hero.svelte"

it("has a header", ()=>{
    render(Hero)
    const boomHeader = screen.getByRole("heading", {name: "BOOM"})
    expect(boomHeader).toBeInTheDocument();
})