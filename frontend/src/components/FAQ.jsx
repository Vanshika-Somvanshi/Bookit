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
      const model = genAI.getGenerativeModel({ model: "gemini-flash-latest" });

      const prompt = `You are the AI assistant for BookIt, a movie ticket booking website. BookIt helps users book movie tickets quickly and easily. You can guide users through signing in, selecting a movie, date, time, seating, and payment (cash, card, UPI). You can also provide information about movies. Answer the following question concisely and accurately: ${faqInput}. Keep the response short, precise, and relevant.`;

      const response = await model.generateContent(prompt);
      const result = response.response.candidates[0].content;
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
        <div className="faq-card">
          <span className="faq-label">✦ Ask anything about movies or BookIt</span>
          <textarea
            className="faq-input"
            placeholder="e.g. 'What is Inception about?' or 'How do I book a ticket?'"
            value={faqInput}
            onChange={handleFaqInputChange}
          />
          <button className="faq-btn" onClick={fetchFaqAnswer} disabled={loading}>
            {loading ? (
              <>
                <HashLoader size={16} color="#fff" cssOverride={{ display: "inline-block" }} />
                &nbsp;Thinking...
              </>
            ) : (
              <>⚡ Get Answer</>
            )}
          </button>

          {!loading && faqResponse && (
            <div className="faq-response-container">
              <h4 className="faq-response-heading">✦ Answer</h4>
              <p className="faq-response-text">{faqResponse}</p>
            </div>
          )}
        </div>
      </div>
    </section>
  );
};

