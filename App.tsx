import React from "react";
import CodeBlock from "./components/CodeBlock";

const App: React.FC = () => {
  const setupCommand = "curl -s https://archon.eshayat.com/script.sh | bash";

  return (
    <main className="bg-[#1e1e2e] text-[#cdd6f4] min-h-screen flex flex-col items-center justify-center font-sans p-4 selection:bg-[#a6e3a1] selection:text-[#1e1e2e]">
      <div className="w-full max-w-2xl text-center">
        <h1 className="text-5xl md:text-6xl font-bold mb-2">
          <span className="text-[#a6e3a1]">Arch</span>on
        </h1>
        <p className="text-lg md:text-xl text-[#bac2de] mb-8">
          The one-command setup for a clean Omarchy Arch Linux environment.
        </p>
        <p className="mb-4">Full setup:</p>
        <CodeBlock command={setupCommand} />
      </div>
    </main>
  );
};

export default App;
