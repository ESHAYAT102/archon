
import React, { useState, useCallback } from 'react';
import CopyIcon from './icons/CopyIcon';
import CheckIcon from './icons/CheckIcon';

interface CodeBlockProps {
  command: string;
}

const CodeBlock: React.FC<CodeBlockProps> = ({ command }) => {
  const [isCopied, setIsCopied] = useState(false);

  const handleCopy = useCallback(() => {
    navigator.clipboard.writeText(command).then(() => {
      setIsCopied(true);
      setTimeout(() => setIsCopied(false), 2000);
    }).catch(err => {
        console.error('Failed to copy text: ', err);
    });
  }, [command]);

  return (
    <div className="relative group bg-[#181825] border border-[#313244] rounded-xl p-4 text-left shadow-lg transition-all duration-300">
      <pre className="overflow-x-auto">
        <code className="font-mono text-sm md:text-base text-[#cdd6f4] break-all">
          {command}
        </code>
      </pre>
      <button
        onClick={handleCopy}
        className={`absolute top-3 right-3 p-2 rounded-lg transition-all duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-[#181825] ${
          isCopied
            ? 'bg-[#a6e3a1] text-[#1e1e2e] focus:ring-[#a6e3a1]'
            : 'bg-[#313244] text-[#cdd6f4] hover:bg-[#45475a] focus:ring-[#585b70] opacity-50 group-hover:opacity-100'
        }`}
        aria-label="Copy command to clipboard"
      >
        {isCopied ? <CheckIcon /> : <CopyIcon />}
      </button>
    </div>
  );
};

export default CodeBlock;
