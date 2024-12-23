import { useEffect } from "react";

function Tests() {
  const fetchData = async () => {
    try {
      const response = await fetch(`/api/test`); // Pas besoin de l'URL complète
      const data = await response.json();
      console.log(data);
    } catch (error) {
      console.error("Error fetching API:", error);
    }
  };

  useEffect(() => {
    fetchData();
  }, []);

  return (
    <div>
      <h1>Backend Test</h1>
    </div>
  );
}

export default Tests;
