import { render, screen } from "@testing-library/svelte";
import SignUpForm from "./SignUpForm";

describe("Signup Page", () => {
  it("has a title", () => {
    render(SignUpForm);
    const SUtitle = screen.getByText("BOOM | Sign Up");
    expect(SUtitle).toBeInTheDocument();
  });
  it("has a user full name input field", () => {
    render(SignUpForm);
    const userTextElement = screen.queryByPlaceholderText("Your Full Name");
    expect(userTextElement).toBeInTheDocument();
  });
  it("has an email input field", () => {
    render(SignUpForm);
    const userMailElement = screen.queryByPlaceholderText("Your E-Mail-Adress");
    expect(userMailElement).toBeInTheDocument();
  });
  
  it("has password input field", () => {
    render(SignUpForm);
    const pwField = screen.getByText("Password");
    expect(pwField).toBeInTheDocument();
  });
  it("has a button for submitting", () => {
    render(SignUpForm);
    const formButton = screen.getByRole("button");
    expect(formButton.textContent).toBe("Sign Up");
    expect(formButton).toBeDisabled();
  });
});
