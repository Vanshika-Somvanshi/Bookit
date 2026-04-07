import { useState } from "react";
import HashLoader from "react-spinners/HashLoader";
import { GoogleGenerativeAI } from "@google/generative-ai";
import './MovieDescription.css';

export const MovieDescription = () => {
  const [movieInput, setMovieInput] = useState("");
  const [response, setResponse] = useState("");
  const [loading, setLoading] = useState(false);

  const handleMovieInputChange = (e) => {
    setMovieInput(e.target.value);
  };

  const fetchDescription = async () => {
    if (!movieInput.trim()) {
      alert("Please enter a movie title or comparison request.");
      return;
    }

    setLoading(true);

    try {
      const genAI = new GoogleGenerativeAI(import.meta.env.VITE_APP_GEMINI_API_KEY);
      const model = genAI.getGenerativeModel({ model: "gemini-flash-latest" });

      const prompt = `You are an expert movie analyst. Answer the question: ${movieInput}. Focus only on movies and related cinematic details. Make it short and crisp. Create different paragraphs for different sections. Don't give anything in bold.`;

      const aiResponse = await model.generateContent(prompt);
      const result = aiResponse.response.candidates[0].content;
      const responseText = result.parts[0].text || "No response found.";
      setResponse(responseText);
    } catch (error) {
      console.error("Error fetching movie description:", error);
      setResponse("Sorry, we couldn't fetch the description. Please try again.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <section className="ai-insights-section container">
      <h4 className="subheading">Personalized Descriptions</h4>
      <h2 className="section-features-heading heading-secondary">
        Uncover Movie Insights with AI
      </h2>

      <div className="ai-insights-inner">
        <div className="ai-insights-card">
          <span className="ai-label">✦ Enter a title or ask a comparison</span>
          <textarea
            className="description-input"
            placeholder="e.g. 'Tell me about Interstellar' or 'Compare Inception and Interstellar'"
            value={movieInput}
            onChange={handleMovieInputChange}
          />
          <button
            className="fetch-description-btn"
            onClick={fetchDescription}
            disabled={loading}
          >
            {loading ? (
              <>
                <HashLoader size={16} color="#fff" cssOverride={{ display: "inline-block" }} />
                &nbsp;Analyzing...
              </>
            ) : (
              <>🎬 Get Insights</>
            )}
          </button>

          {!loading && response && (
            <div className="response-container">
              <h3 className="response-heading">✦ Movie Insight</h3>
              <p className="response-text">{response}</p>
            </div>
          )}
        </div>
      </div>
    </section>
  );
};
