import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'career_domain_model.dart';

class MedicalCommerceDomainData {
  static List<CareerDomain> getMedicalDomains() {
    return [
      _createDomain(
        id: 'doctor',
        name: 'Doctor (MBBS)',
        field: 'Medical',
        description: 'Diagnose and treat illnesses as a medical professional.',
        icon: LucideIcons.stethoscope,
        color: Colors.red,
        cert: 'MBBS Degree & NEET PG',
        skills: [
          'NEET Biology',
          'Clinical Medicine',
          'Surgery Basics',
          'Patient Care',
          'Specialization',
        ],
      ),
      _createDomain(
        id: 'nursing',
        name: 'Nursing',
        field: 'Medical',
        description: 'Provide essential care and support to patients.',
        icon: LucideIcons.heart,
        color: Colors.pink,
        cert: 'B.Sc. Nursing',
        skills: [
          'Anatomy',
          'First Aid',
          'Patient Monitoring',
          'Medication Mgmt',
          'Hospital Ethics',
        ],
      ),
      _createDomain(
        id: 'pharmacy',
        name: 'Pharmacy',
        field: 'Medical',
        description: 'Specialize in medicines and pharmaceutical science.',
        icon: LucideIcons.pill,
        color: Colors.green,
        cert: 'B.Pharm / Pharm.D',
        skills: [
          'Chemistry',
          'Pharmacology',
          'Drug Interaction',
          'Clinical Pharmacy',
          'R&D',
        ],
      ),
      _createDomain(
        id: 'physiotherapy',
        name: 'Physiotherapy',
        field: 'Medical',
        description: 'Help patients regain movement and physical function.',
        icon: LucideIcons.activity,
        color: Colors.orange,
        cert: 'BPT (Bachelor of Physiotherapy)',
        skills: [
          'Biomechanics',
          'Exercise Therapy',
          'Rehabilitation',
          'Sports Medicine',
          'Electropathy',
        ],
      ),
      _createDomain(
        id: 'mlt',
        name: 'Medical Lab Technology',
        field: 'Medical',
        description: 'Perform lab tests to assist doctors in diagnosis.',
        icon: LucideIcons.microscope,
        color: Colors.blue,
        cert: 'BMLT / DMLT',
        skills: [
          'Biochemistry',
          'Pathology',
          'Microbiology',
          'Hematology',
          'Lab Safety',
        ],
      ),
      _createDomain(
        id: 'radiology',
        name: 'Radiology',
        field: 'Medical',
        description: 'Specialize in medical imaging like X-rays and MRI.',
        icon: LucideIcons.scan,
        color: Colors.purple,
        cert: 'B.Sc. Radiology',
        skills: [
          'Radiation Physics',
          'Imaging Tech',
          'Anatomy',
          'CT Scanning',
          'MRI Procedures',
        ],
      ),
      _createDomain(
        id: 'public_health',
        name: 'Public Health',
        field: 'Medical',
        description: 'Improve community health through policy and research.',
        icon: LucideIcons.users,
        color: Colors.teal,
        cert: 'Masters in Public Health (MPH)',
        skills: [
          'Epidemiology',
          'Health Policy',
          'Biostatistics',
          'Community Outreach',
          'Program Evaluation',
        ],
      ),
      _createDomain(
        id: 'healthcare_admin',
        name: 'Healthcare Administration',
        field: 'Medical',
        description: 'Manage the operations of hospitals and clinics.',
        icon: LucideIcons.building,
        color: Colors.indigo,
        cert: 'MHA (Masters of Healthcare Admin)',
        skills: [
          'Hospital Ops',
          'Health Law',
          'Financial Mgmt',
          'Quality Control',
          'HR in Health',
        ],
      ),
      _createDomain(
        id: 'biomed_eng',
        name: 'Biomedical Engineering',
        field: 'Medical',
        description: 'Design equipment and software for healthcare.',
        icon: LucideIcons.cpu,
        color: Colors.cyan,
        cert: 'B.Tech Biomedical Engineering',
        skills: [
          'Bio-Instrumentation',
          'Signal Processing',
          'Tissue Engineering',
          'Medical Imaging',
          'Robotics',
        ],
      ),
    ];
  }

  static List<CareerDomain> getCommerceDomains() {
    return [
      _createDomain(
        id: 'ca',
        name: 'Chartered Accountant (CA)',
        field: 'Commerce',
        description: 'Expertise in accounting, auditing, and taxation.',
        icon: LucideIcons.calculator,
        color: Colors.blue,
        cert: 'ICAI Chartered Accountant',
        skills: [
          'Accounting Std',
          'Taxation Law',
          'Auditing',
          'Final Accounts',
          'Strategic Mgmt',
        ],
      ),
      _createDomain(
        id: 'cs',
        name: 'Company Secretary (CS)',
        field: 'Commerce',
        description: 'Manage legal and corporate compliance of companies.',
        icon: LucideIcons.gavel,
        color: Colors.brown,
        cert: 'ICSI Company Secretary',
        skills: [
          'Company Law',
          'Corporate Governance',
          'Secretarial Audit',
          'Capital Markets',
          'Drafting',
        ],
      ),
      _createDomain(
        id: 'cma',
        name: 'Cost Management Accountant',
        field: 'Commerce',
        description: 'Specialize in cost control and financial strategy.',
        icon: LucideIcons.trendingUp,
        color: Colors.green,
        cert: 'ICMAI Cost Accountant',
        skills: [
          'Cost Accounting',
          'Direct Tax',
          'Operations Mgmt',
          'Fin. Reporting',
          'Cost Audit',
        ],
      ),
      _createDomain(
        id: 'banking_finance',
        name: 'Banking & Finance',
        field: 'Commerce',
        description: 'Work in financial institutions and wealth management.',
        icon: LucideIcons.landmark,
        color: Colors.blueAccent,
        cert: 'MBA Finance / CAIIB',
        skills: [
          'Retail Banking',
          'Credit Risk',
          'Wealth Mgmt',
          'Fin. Markets',
          'Customer Rel.',
        ],
      ),
      _createDomain(
        id: 'invest_banking',
        name: 'Investment Banking',
        field: 'Commerce',
        description: 'Manage capital raising and corporate mergers.',
        icon: LucideIcons.dollarSign,
        color: Colors.deepPurple,
        cert: 'CFA / MBA (Top Tier)',
        skills: [
          'Valuation',
          'M&A Strategy',
          'Equity Research',
          'Fixed Income',
          'Fin. Analysis',
        ],
      ),
      _createDomain(
        id: 'fin_analyst',
        name: 'Financial Analyst',
        field: 'Commerce',
        description: 'Analyze financial data to assist investment decisions.',
        icon: LucideIcons.barChart2,
        color: Colors.amber,
        cert: 'CFA (Chartered Financial Analyst)',
        skills: [
          'Portfolio Mgmt',
          'Derivatives',
          'Ethical Std',
          'Economics',
          'Quants',
        ],
      ),
      _createDomain(
        id: 'acc_auditing',
        name: 'Accounting & Auditing',
        field: 'Commerce',
        description: 'Maintain and verify financial records for accuracy.',
        icon: LucideIcons.fileSearch,
        color: Colors.grey,
        cert: 'B.Com / ACCA',
        skills: [
          'Double Entry',
          'Vouching',
          'Internal Audit',
          'Tally/ERP',
          'Compliance',
        ],
      ),
      _createDomain(
        id: 'bus_mgmt',
        name: 'Business Management (BBA)',
        field: 'Commerce',
        description: 'Lead and manage organizational operations.',
        icon: LucideIcons.briefcase,
        color: Colors.indigo,
        cert: 'MBA / BBA',
        skills: [
          'Leadership',
          'Marketing Ops',
          'Consumer Behavior',
          'Operations',
          'Strategy',
        ],
      ),
      _createDomain(
        id: 'hr_mgmt',
        name: 'Human Resource Management',
        field: 'Commerce',
        description: 'Manage employee relations, hiring, and culture.',
        icon: LucideIcons.userPlus,
        color: Colors.orange,
        cert: 'MBA HR / PHR',
        skills: [
          'Recruitment',
          'Labor Laws',
          'Performance Appraisal',
          'Training',
          'Org Psychology',
        ],
      ),
      _createDomain(
        id: 'entrepreneur',
        name: 'Entrepreneurship',
        field: 'Commerce',
        description: 'Build and scale your own business venture.',
        icon: LucideIcons.rocket,
        color: Colors.redAccent,
        cert: 'Diploma in Entrepreneurship',
        skills: [
          'Business Model',
          'Pitched Deck',
          'Venture Capital',
          'Scaling',
          'Innovation',
        ],
      ),
    ];
  }

  static List<CareerDomain> getAll() {
    return [...getMedicalDomains(), ...getCommerceDomains()];
  }

  static CareerDomain _createDomain({
    required String id,
    required String name,
    required String field,
    required String description,
    required IconData icon,
    required Color color,
    required String cert,
    required List<String> skills,
  }) {
    return CareerDomain(
      id: id,
      name: name,
      field: field,
      description: description,
      icon: icon,
      color: color,
      steps: [
        RoadmapStep(
          title: 'Step 1: Foundation Education',
          description:
              'Complete your 10+2 with a focus on ${field == "Medical" ? "Science (PCB)" : "Commerce/Maths"} and key subjects.',
        ),
        RoadmapStep(
          title: 'Step 2: Entrance & Eligibility',
          description:
              'Prepare and qualify for key exams like ${field == "Medical" ? "NEET" : "Entrance Tests"} or meet degree requirements.',
        ),
        RoadmapStep(
          title: 'Step 3: Core Academic Subjects',
          description:
              'Master essential concepts such as ${skills[0]} and ${skills[1]} during your degree/professional course.',
        ),
        RoadmapStep(
          title: 'Step 4: Practical Training',
          description:
              'Gain hands-on experience through ${field == "Medical" ? "Clinical Rotations" : "Internships"} focusing on ${skills[2]}.',
        ),
        RoadmapStep(
          title: 'Step 5: Advanced Specialization',
          description:
              'Deep dive into specialized areas like ${skills[3]} and ${skills[4]} to stand out in the field.',
        ),
        RoadmapStep(
          title: 'Step 6: Certification & Career Entry',
          description:
              'Apply for your final $cert and register with professional bodies to start your professional practice.',
          certification: cert,
        ),
      ],
    );
  }
}
