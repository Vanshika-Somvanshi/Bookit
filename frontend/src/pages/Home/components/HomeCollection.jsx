import { useEffect, useState } from "react";
import { CollectionCard } from "../../../components/CollectionCard";
import axios from "axios";
import HashLoader from "react-spinners/HashLoader";

export const HomeCollection = () => {
  const override = {
    display: "block",
    marginLeft: "auto",
    marginRight: "auto",
  };

  const [movieData, setMovieData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(false);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await axios.get(
          `${import.meta.env.VITE_API_URL}/latestMovies`
        );
        // Backend may return an error object instead of an array if DB fails
        if (Array.isArray(response.data)) {
          setMovieData(response.data);
        } else {
          console.error("Unexpected API response:", response.data);
          setError(true);
        }
      } catch (err) {
        console.error(err);
        setError(true);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  const latestMoviesCards = movieData.map((latestMovie) => {
    return <CollectionCard key={latestMovie.id} {...latestMovie} />;
  });

  const latestMovieCardsDouble = movieData.map((latestMovie) => {
    return <CollectionCard key={latestMovie.id + 6} {...latestMovie} />;
  });

  return (
    <section className="section-home-collection" id="nowShowing">
      <div className="home-collection-heading-container">
        <h1 className="heading-secondary heading-collection">
          Now Playing &rarr;
        </h1>
      </div>

      {loading && <HashLoader cssOverride={override} color="#eb3656" />}
      {!loading && error && (
        <p style={{ textAlign: "center", color: "#eb3656", padding: "2rem" }}>
          Could not load movies. Please check the server connection.
        </p>
      )}
      {!loading && !error && (
        <div className="home-collection-container">
          <div className="home-collection-inner">{latestMoviesCards}</div>
          <div className="home-collection-inner">{latestMovieCardsDouble}</div>
        </div>
      )}
    </section>
  );
};
