import '../models/skill_model.dart';

class SkillRecommendationData {
  static final Map<String, List<Skill>> skillRecommendations = {
    "soft_dev": [
      Skill(
        name: "Version Control (Git)",
        description:
            "Master industry-standard version control for code collaboration.",
        level: "Beginner",
        duration: "2-3 weeks",
        icon: "🌲",
      ),
      Skill(
        name: "Clean Code",
        description:
            "Writing readable, maintainable, and scalable software architecture.",
        level: "Intermediate",
        duration: "4-6 weeks",
        icon: "✨",
      ),
      Skill(
        name: "System Design",
        description:
            "Designing high-availability and distributed cloud systems.",
        level: "Advanced",
        duration: "2-3 months",
        icon: "🏗️",
      ),
    ],
    "mob_dev": [
      Skill(
        name: "Material 3 Design",
        description:
            "Building modern user interfaces with Google's latest design system.",
        level: "Beginner",
        duration: "1-2 weeks",
        icon: "🎨",
      ),
      Skill(
        name: "State Management",
        description:
            "Advanced data flow control using Provider, Bloc, or Riverpod.",
        level: "Intermediate",
        duration: "3-4 weeks",
        icon: "🔄",
      ),
      Skill(
        name: "Native Integration",
        description:
            "Bridging Flutter with native Android/iOS APIs and hardware.",
        level: "Advanced",
        duration: "4-6 weeks",
        icon: "🔌",
      ),
    ],
    "web_dev": [
      Skill(
        name: "Responsive Design",
        description:
            "Crafting layouts that adapt perfectly to any screen size.",
        level: "Beginner",
        duration: "2 weeks",
        icon: "📱",
      ),
      Skill(
        name: "Backend Auth",
        description: "Implementing secure JWT or OAuth2 authentication flows.",
        level: "Intermediate",
        duration: "3 weeks",
        icon: "🔐",
      ),
      Skill(
        name: "Web Performance",
        description:
            "Optimizing Core Web Vitals and advanced caching strategies.",
        level: "Advanced",
        duration: "4 weeks",
        icon: "⚡",
      ),
    ],
    "ai_ml": [
      Skill(
        name: "Python Foundations",
        description:
            "Learn Python syntax and data structures for scientific computing.",
        level: "Beginner",
        duration: "4 weeks",
        icon: "🐍",
      ),
      Skill(
        name: "Model Training",
        description: "Training neural networks using TensorFlow or PyTorch.",
        level: "Intermediate",
        duration: "8 weeks",
        icon: "🧠",
      ),
      Skill(
        name: "MLOps",
        description:
            "Deploying and monitoring machine learning models in production.",
        level: "Advanced",
        duration: "12 weeks",
        icon: "🚀",
      ),
    ],
    "doctor": [
      Skill(
        name: "Medical Ethics",
        description:
            "Understanding the fundamental principles of healthcare ethics.",
        level: "Beginner",
        duration: "2 weeks",
        icon: "⚖️",
      ),
      Skill(
        name: "Emergency Care",
        description:
            "Procedures and protocols for handling critical medical scenarios.",
        level: "Intermediate",
        duration: "3 months",
        icon: "🚑",
      ),
      Skill(
        name: "Specialized Surgery",
        description: "Advanced techniques in specific surgical fields.",
        level: "Advanced",
        duration: "2-3 years",
        icon: "🔪",
      ),
    ],
    "nursing": [
      Skill(
        name: "Patient Assessment",
        description: "Core competency in vital signs monitoring and triage.",
        level: "Beginner",
        duration: "4 weeks",
        icon: "🌡️",
      ),
      Skill(
        name: "Wound Care",
        description: "Sterile techniques and advanced dressing management.",
        level: "Intermediate",
        duration: "6 weeks",
        icon: "🩹",
      ),
      Skill(
        name: "Critical Care Nursing",
        description: "Managing life-support systems (ICU/CCU environments).",
        level: "Advanced",
        duration: "6 months",
        icon: "🩺",
      ),
    ],
    "pharmacy": [
      Skill(
        name: "Drug Chemistry",
        description: "Foundational knowledge of chemical structures of drugs.",
        level: "Beginner",
        duration: "8 weeks",
        icon: "🧪",
      ),
      Skill(
        name: "Pharmacotherapy",
        description: "Clinical usage of drugs for disease management.",
        level: "Intermediate",
        duration: "4 months",
        icon: "💊",
      ),
      Skill(
        name: "Hospital Pharmacy Mgmt",
        description: "Managing inventory, policy, and clinical drug trials.",
        level: "Advanced",
        duration: "1 year",
        icon: "🏥",
      ),
    ],
    "physiotherapy": [
      Skill(
        name: "Functional Anatomy",
        description: "Study of musculoskeletal system movement.",
        level: "Beginner",
        duration: "6 weeks",
        icon: "🦴",
      ),
      Skill(
        name: "Electrotherapy",
        description: "Applying electrical stimulation for muscle recovery.",
        level: "Intermediate",
        duration: "8 weeks",
        icon: "⚡",
      ),
      Skill(
        name: "Neuro-Rehabilitation",
        description: "Advanced physical therapy for stroke or spinal injury.",
        level: "Advanced",
        duration: "5 months",
        icon: "🧠",
      ),
    ],
    "mlt": [
      Skill(
        name: "Clinical Biochemistry",
        description: "Chemical analysis of body fluids for diagnosis.",
        level: "Beginner",
        duration: "4 weeks",
        icon: "🩸",
      ),
      Skill(
        name: "Pathology Techniques",
        description: "Microscopic analysis of tissue samples.",
        level: "Intermediate",
        duration: "3 months",
        icon: "🔬",
      ),
      Skill(
        name: "Forensic Serology",
        description: "Advanced analysis of blood and fluids for legal cases.",
        level: "Advanced",
        duration: "6 months",
        icon: "🚔",
      ),
    ],
    "radiology": [
      Skill(
        name: "Radiation Physics",
        description: "Fundamental physics behind X-ray and CT imaging.",
        level: "Beginner",
        duration: "6 weeks",
        icon: "⚛️",
      ),
      Skill(
        name: "Sectional Anatomy",
        description: "Mapping body parts in cross-sectional views (CT/MRI).",
        level: "Intermediate",
        duration: "4 months",
        icon: "📉",
      ),
      Skill(
        name: "Interventional Radiology",
        description: "Using imaging for minimally invasive surgery guidance.",
        level: "Advanced",
        duration: "1 year",
        icon: "🎯",
      ),
    ],
    "public_health": [
      Skill(
        name: "Epidemiology",
        description: "Studying the distribution and patterns of health events.",
        level: "Beginner",
        duration: "6 weeks",
        icon: "📊",
      ),
      Skill(
        name: "Health Promotion",
        description: "Designing community-based wellness initiatives.",
        level: "Intermediate",
        duration: "4 months",
        icon: "🗣️",
      ),
      Skill(
        name: "Global Health Policy",
        description:
            "Navigating international health regulations and WHO standards.",
        level: "Advanced",
        duration: "9 months",
        icon: "🌍",
      ),
    ],
    "healthcare_admin": [
      Skill(
        name: "Hospital Operations",
        description: "Basics of managing medical departments and staff.",
        level: "Beginner",
        duration: "3 months",
        icon: "🏢",
      ),
      Skill(
        name: "Healthcare Policy",
        description: "Understanding legal and ethical health frameworks.",
        level: "Intermediate",
        duration: "5 months",
        icon: "📜",
      ),
      Skill(
        name: "Quality Management",
        description: "Implementing ISO standards in clinical healthcare.",
        level: "Advanced",
        duration: "8 months",
        icon: "✅",
      ),
    ],
    "biomed_eng": [
      Skill(
        name: "Bio-Instrumentation",
        description: "Designing sensors to monitor physiological signals.",
        level: "Beginner",
        duration: "3 months",
        icon: "📟",
      ),
      Skill(
        name: "Medical Device Regs",
        description: "Navigating FDA/CE compliance for medical hardware.",
        level: "Intermediate",
        duration: "5 months",
        icon: "⚖️",
      ),
      Skill(
        name: "Tissue Engineering",
        description: "Developing synthetic scaffolds for organ regeneration.",
        level: "Advanced",
        duration: "1 year",
        icon: "🧬",
      ),
    ],
    "ca": [
      Skill(
        name: "Tally Prime",
        description:
            "Foundational accounting software used globally for bookkeeping.",
        level: "Beginner",
        duration: "4 weeks",
        icon: "📊",
      ),
      Skill(
        name: "Corporate Audit",
        description:
            "Advanced techniques in auditing large-scale corporate finances.",
        level: "Intermediate",
        duration: "3 months",
        icon: "🏢",
      ),
      Skill(
        name: "Tax Strategy",
        description: "Complex tax planning and international compliance.",
        level: "Advanced",
        duration: "6 months",
        icon: "💰",
      ),
    ],
    "cs": [
      Skill(
        name: "Company Law",
        description: "Mastering the legal framework for corporate entities.",
        level: "Beginner",
        duration: "2 months",
        icon: "⚖️",
      ),
      Skill(
        name: "Securities Compliance",
        description: "Ensuring adherence to SEBI and stock market regulations.",
        level: "Intermediate",
        duration: "4 months",
        icon: "📈",
      ),
      Skill(
        name: "Corridor Meetings",
        description: "Effective board management and minute-taking mastery.",
        level: "Advanced",
        duration: "6 months",
        icon: "📅",
      ),
    ],
    "banking_finance": [
      Skill(
        name: "Retail Banking",
        description: "Understanding loans, deposits, and bank accounts.",
        level: "Beginner",
        duration: "4 weeks",
        icon: "🏦",
      ),
      Skill(
        name: "Credit Risk Analysis",
        description: "Evaluating the creditworthiness of borrowers.",
        level: "Intermediate",
        duration: "4 months",
        icon: "⚖️",
      ),
      Skill(
        name: "Mergers & Acquisitions",
        description: "Managing corporate buyouts and bank consolidations.",
        level: "Advanced",
        duration: "9 months",
        icon: "🤝",
      ),
    ],
    "invest_banking": [
      Skill(
        name: "Valuation Modeling",
        description:
            "Complex DCF and LBO modeling for multi-billion dollar deals.",
        level: "Beginner",
        duration: "3 months",
        icon: "💹",
      ),
      Skill(
        name: "IPO Preparation",
        description: "Navigating companies through the public listing process.",
        level: "Intermediate",
        duration: "6 months",
        icon: "🚀",
      ),
      Skill(
        name: "Asset Restructuring",
        description:
            "Advanced strategies for managing distressed corporate debt.",
        level: "Advanced",
        duration: "1 year",
        icon: "🔄",
      ),
    ],
    "fin_analyst": [
      Skill(
        name: "Financial Statements",
        description: "Interpreting balance sheets and cash flow statements.",
        level: "Beginner",
        duration: "4 weeks",
        icon: "📄",
      ),
      Skill(
        name: "Valuation Modeling",
        description: "Implementing DCF and Comparable Company Analysis.",
        level: "Intermediate",
        duration: "3 months",
        icon: "📈",
      ),
      Skill(
        name: "Portfolio Theory",
        description: "Advanced asset allocation and risk management.",
        level: "Advanced",
        duration: "6 months",
        icon: "👜",
      ),
    ],
    "acc_auditing": [
      Skill(
        name: "Internal Controls",
        description: "Establishing systems to prevent financial fraud.",
        level: "Beginner",
        duration: "2 months",
        icon: "🛡️",
      ),
      Skill(
        name: "Forensic Accounting",
        description: "Investigating financial discrepancies and theft.",
        level: "Intermediate",
        duration: "5 months",
        icon: "🔍",
      ),
      Skill(
        name: "Statutory Reporting",
        description: "Mastering complex year-end reporting for conglomerates.",
        level: "Advanced",
        duration: "9 months",
        icon: "📊",
      ),
    ],
    "bus_mgmt": [
      Skill(
        name: "Org. Behavior",
        description: "Understanding team dynamics and group psychology.",
        level: "Beginner",
        duration: "4 weeks",
        icon: "👥",
      ),
      Skill(
        name: "Strategic Analysis",
        description: "Applying SWOT, PESTEL, and Porter's Five Forces.",
        level: "Intermediate",
        duration: "3 months",
        icon: "♟️",
      ),
      Skill(
        name: "Crisis Management",
        description: "Navigating companies through hostile market shifts.",
        level: "Advanced",
        duration: "5 months",
        icon: "🚨",
      ),
    ],
    "hr_mgmt": [
      Skill(
        name: "Talent Acquisition",
        description: "Effective sourcing and interviewing for key roles.",
        level: "Beginner",
        duration: "1 month",
        icon: "👤",
      ),
      Skill(
        name: "Labor Relations",
        description: "Managing trade union negotiations and labor laws.",
        level: "Intermediate",
        duration: "4 months",
        icon: "📋",
      ),
      Skill(
        name: "Org. Design",
        description: "Architecting efficient hierarchies and culture shifts.",
        level: "Advanced",
        duration: "7 months",
        icon: "🏛️",
      ),
    ],
    "entrepreneur": [
      Skill(
        name: "Lean Canvas",
        description: "Mapping out business models for new startups.",
        level: "Beginner",
        duration: "2 weeks",
        icon: "📋",
      ),
      Skill(
        name: "Growth Hacking",
        description: "Low-cost strategies for rapid user acquisition.",
        level: "Intermediate",
        duration: "3 months",
        icon: "💹",
      ),
      Skill(
        name: "Venture Capital",
        description: "Raising Series A/B funding and equity negotiation.",
        level: "Advanced",
        duration: "6 months",
        icon: "💎",
      ),
    ],
    "dig_market": [
      Skill(
        name: "SEO Fundamentals",
        description: "Optimizing content for search engine visibility.",
        level: "Beginner",
        duration: "4 weeks",
        icon: "🔍",
      ),
      Skill(
        name: "Performance Marketing",
        description: "Managing paid ad campaigns across Meta and Google.",
        level: "Intermediate",
        duration: "3 months",
        icon: "📈",
      ),
      Skill(
        name: "Marketing Analytics",
        description: "Advanced data-driven strategy and attribution modeling.",
        level: "Advanced",
        duration: "6 months",
        icon: "📉",
      ),
    ],
  };

  static List<Skill> getSkillsForDomain(String domainId) {
    return skillRecommendations[domainId] ?? [];
  }
}
