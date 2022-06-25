import { render, screen } from "@testing-library/svelte";
import Hero from "./Hero.svelte";

describe("Landing Page", () => {
  it("has a title", () => {
    render(Hero);
    const LPtitle = screen.getByText("BOOM");
    expect(LPtitle).toBeInTheDocument();
  });
  it("has a subtitle", () => {
    render(Hero);
    const LPsubTitle = screen.getByText(
      "A Page takes you to kids Mode where you can find your kids favorite clothes"
    );
    expect(LPsubTitle).toBeInTheDocument();
  });
  it("has a button", () => {
    render(Hero);
    const LPsubTitle = screen.getByText("Let's shop");
    expect(LPsubTitle.textContent).toBe("Let's shop");
    expect(LPsubTitle).toBeInTheDocument();
  });
  it("has the first images", () => {
    const { getByAltText } = render(Hero);
    const LPImg = getByAltText("firstImg");
    expect(LPImg).toBeInTheDocument();
  });
  it("has the second images", () => {
    const { getByAltText } = render(Hero);
    const LPImg = getByAltText("secondImg");
    expect(LPImg).toBeInTheDocument();
  });
  it("has the third images", () => {
    const { getByAltText } = render(Hero);
    const LPImg = getByAltText("thirdImg");
    expect(LPImg).toBeInTheDocument();
  });
});
