import { useState } from "react";
import HashLoader from "react-spinners/HashLoader";
import { GoogleGenerativeAI } from "@google/generative-ai";
import "./FaqSection.css";

export const FAQ = () => {
  const [faqInput, setFaqInput] = useState("");
  const [faqResponse, setFaqResponse] = useState("");
  const [loading, setLoading] = useState(false);

  const handleFaqInputChange = (e) => {
    setFaqInput(e.target.value);
  };

  const fetchFaqAnswer = async () => {
    if (!faqInput.trim()) {
      alert("Please enter a question.");
      return;
    }

    setLoading(true);

    try {
      const genAI = new GoogleGenerativeAI(import.meta.env.VITE_APP_GEMINI_API_KEY);
      const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });

      const prompt = `You are the AI assistant for the Rapid Ticket website. Rapid Ticket helps users book movie tickets quickly and easily. You can guide users through the process of signing in, logging in, selecting a movie, date, time, seating, and payment method (options include cash, card, and UPI). Additionally, you can provide information about movies through this AI section. Answer the following question related to Rapid Ticket or movies: ${faqInput}. Keep the response short, precise, and relevant to the website's features.`;

      
      const response = await model.generateContent(prompt);
      const result = response.response.candidates[0].content; // Adjust based on actual response structure
        console.log(result.parts[0].text )
      setFaqResponse(result.parts[0].text || "Sorry, I couldn't find an answer to your question.");
    } catch (error) {
      console.error("Error fetching FAQ answer:", error);
      setFaqResponse("Sorry, something went wrong. Please try again later.");
    } finally {
      setLoading(false);
    }
  };

  const override = {
    display: "block",
    margin: "0 auto",
    borderColor: "#eb3656",
  };

  return (
    <section className="faq-section container">
      <h4 className="subheading">Common Questions</h4>
      <h2 className="faq-heading heading-secondary">Movie FAQs</h2>

      <div className="faq-contents">
        <textarea
          className="faq-input"
          placeholder="Ask a question (e.g., 'What is Inception about?')"
          value={faqInput}
          onChange={handleFaqInputChange}
        />
        <button className="faq-btn" onClick={fetchFaqAnswer} disabled={loading}>
          {loading ? "Fetching..." : "Get Answer"}
        </button>

        {loading ? (
          <HashLoader cssOverride={override} color="#eb3656" />
        ) : (
          faqResponse && (
            <div className="faq-response-container">
              <h4 className="faq-response-heading">Answer:</h4>
              <p className="faq-response-text">{faqResponse}</p>
            </div>
          )
        )}
      </div>
    </section>
  );
};
