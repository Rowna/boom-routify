import "@testing-library/jest-dom";
import { render, screen } from "@testing-library/svelte";
import artID from "../pages/singleView/[artID].svelte";

describe("Single View", () => {
  it("has a header", () => {
    render(artID);
    const artImg = screen.getByText("BOOM");
    expect(artImg).toBeInTheDocument();
  });

  test("has an image", () => {
    const { getByAltText } = render(artID);
    const svImg = getByAltText("Bild");
    expect(svImg).toBeInTheDocument();
  });
  
  test("has a review button", () => {
    const { getByText } = render(artID);
    const svButton = getByText("Edit your Recension");
    expect(svButton).toBeInTheDocument();
  });
});
