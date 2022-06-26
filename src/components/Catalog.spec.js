import { render, screen } from "@testing-library/svelte";
import catalog from "../pages/catalog";
import CatalogItem from "./CatalogItem";

describe("Catalog Page", () => {
  it("has a title", () => {
    render(catalog);
    const caTitle = screen.getByText("BOOM");
    expect(caTitle).toBeInTheDocument();
  });

  describe("CatalogItem Page", () => {
    it("has an image", () => {
      render(CatalogItem);

      const artImg = screen.getByAltText("article");

      expect(artImg).toBeInTheDocument();
    });

    it("has an article title", () => {
      const title = "JungeAnzug";
      // const desc = "Sommer";
      // const img = "19.jpeg";
      // const _id = "62ab27c4c7e59e6f13dff1af";
      // const price = 16.99;

      const canonical_url = "http://localhost:5000/catalog";
      const { container, getByText } = render(CatalogItem, {
        props: {

          article: {
            title,
            // _id,
            // img,
            // desc,
            // price,
            // canonical_url,
          },
        },
      });
      expect("http://localhost:5000/catalog").toBe(`${canonical_url}`);
      expect(getByText(title)).toBeInTheDocument();
    });

    it("has an article subtitle", () => {
      // const title = "JungeAnzug";
      const desc = "Sommer";
      // const img = "19.jpeg";
      // const _id = "62ab27c4c7e59e6f13dff1af";
      // const price = 16.99;
      const canonical_url = "http://localhost:5000/catalog";
      
      const { container, getByText } = render(CatalogItem, {
        props: {
          article: {
            // title,
            // _id,
            // img,
            desc,
            // price,
            // canonical_url,
          },
        },
      });
      expect("http://localhost:5000/catalog").toBe(`${canonical_url}`);
      expect(getByText(desc)).toBeInTheDocument();
    });

    it("has a price", () => {
      // const _id = "62ab27c4c7e59e6f13dff1af";
      // const title = "JungeAnzug";
      // const desc = "Sommer";
      // const img = "19.jpeg";
      const price = 16.99;
      const canonical_url = "http://localhost:5000/catalog";
      const { container, getByText } = render(CatalogItem, {
        props: {
          article: {
            // _id,
            // title,
            // desc,
            // img,
            price,
            // canonical_url,
          },
        },
      });
      expect("http://localhost:5000/catalog").toBe(`${canonical_url}`);
      expect(getByText(price)).toBeInTheDocument();
    });
  });
});
