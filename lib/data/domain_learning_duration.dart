class DomainLearningDuration {
  static final Map<String, String> domainLearningDuration = {
    "soft_dev": "12–18 months",
    "mob_dev": "8–12 months",
    "web_dev": "6–10 months",
    "ai_ml": "18–24 months",
    "data_sci": "12–15 months",
    "doctor": "5.5–10 years",
    "ca": "4–5 years",
    "ui_ux": "6–9 months",
    "cybersec": "12–18 months",
    "cloud_comp": "9–12 months",
  };

  static String getDurationForDomain(String domainId) {
    return domainLearningDuration[domainId] ?? "Duration not available";
  }
}
