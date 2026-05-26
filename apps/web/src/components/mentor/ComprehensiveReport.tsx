import React from 'react'
import ReactMarkdown from 'react-markdown'
import remarkGfm from 'remark-gfm'
import { Printer } from 'lucide-react'

interface ComprehensiveReportProps {
  studentName: string
  markdownContent: string
}

export default function ComprehensiveReport({ studentName, markdownContent }: ComprehensiveReportProps) {
  const handlePrint = () => {
    window.print()
  }

  return (
    <div className="flex flex-col h-full bg-white dark:bg-[#0c0d10] rounded-xl shadow-sm border border-brand-100 dark:border-white/5 overflow-hidden">
      {/* Header bar (Not visible in print) */}
      <div className="print:hidden flex items-center justify-between px-6 py-4 border-b border-brand-100 dark:border-white/5 bg-brand-50/50 dark:bg-white/[0.02]">
        <h3 className="text-lg font-semibold text-brand-900 dark:text-white">
          Comprehensive Report: {studentName}
        </h3>
        <button
          onClick={handlePrint}
          className="flex items-center gap-2 px-4 py-2 bg-brand-600 text-white rounded-lg hover:bg-brand-700 transition-colors shadow-sm font-medium"
        >
          <Printer size={18} />
          Download PDF
        </button>
      </div>

      {/* Report Content (Printable area) */}
      <div className="flex-1 overflow-y-auto p-8 print:p-0 print:overflow-visible bg-white dark:bg-[#0c0d10]">
        
        {/* Print-only Header */}
        <div className="hidden print:block mb-8 text-center border-b-2 border-brand-900 pb-4">
          <h1 className="text-3xl font-bold text-black uppercase tracking-wider">EduPredict ERP</h1>
          <h2 className="text-xl text-gray-700 mt-2">Comprehensive Student Profile Report</h2>
          <p className="text-sm text-gray-500 mt-1">Generated for: {studentName} on {new Date().toLocaleDateString()}</p>
        </div>

        {/* Markdown Render */}
        <article className="prose prose-brand dark:prose-invert max-w-none print:prose-p:text-black print:prose-headings:text-black print:prose-td:border-gray-300 print:prose-th:border-gray-300 print:prose-table:border-gray-300">
          <ReactMarkdown remarkPlugins={[remarkGfm]}>
            {markdownContent}
          </ReactMarkdown>
        </article>

        {/* Print-only Footer */}
        <div className="hidden print:block mt-12 pt-4 border-t border-gray-300 text-center text-xs text-gray-500">
          End of Report - EduPredict Student Tracker System - Authorized Mentor Copy
        </div>
      </div>
      
      {/* CSS for print formatting - hide sidebar and other page elements */}
      <style>{`
        @media print {
          body * {
            visibility: hidden;
          }
          aside, nav {
            display: none !important;
          }
          /* Make the report container visible and full width */
          .print\\:block {
             visibility: visible;
          }
          article, article * {
            visibility: visible;
          }
          .prose {
             color: black !important;
          }
          .prose h1, .prose h2, .prose h3, .prose h4, .prose strong {
             color: black !important;
          }
          .prose table {
             border-collapse: collapse;
             width: 100%;
          }
          .prose td, .prose th {
             border: 1px solid #ddd;
             padding: 8px;
          }
          /* Absolute positioning to bring the printable area to the top left of the page */
          .overflow-y-auto {
            position: absolute;
            left: 0;
            top: 0;
            width: 100%;
            height: auto;
            overflow: visible !important;
          }
        }
      `}</style>
    </div>
  )
}
