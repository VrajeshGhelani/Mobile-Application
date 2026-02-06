import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'career_domain_model.dart';
import 'medical_commerce_domain_data.dart';

class CareerDomainData {
  static List<CareerDomain> getAllDomains() {
    final techDomains = [
      // 💻 CORE TECH
      _createDomain(
        id: 'soft_dev',
        name: 'Software Development',
        field: 'Tech',
        description:
            'Design, code, and maintain software systems and applications.',
        icon: LucideIcons.code,
        color: Colors.blue,
        cert: 'IEEE Professional Software Developer',
        skills: [
          'Algorithms',
          'Java/C++',
          'System Design',
          'Unit Testing',
          'Software Lifecycle',
        ],
      ),
      _createDomain(
        id: 'mob_dev',
        name: 'Mobile App Development',
        field: 'Tech',
        description:
            'Create native or cross-platform apps for iOS and Android.',
        icon: LucideIcons.smartphone,
        color: Colors.indigo,
        cert: 'Google Associate Android Developer',
        skills: [
          'Flutter/Swift',
          'Mobile UI',
          'API Integration',
          'App Store Publishing',
          'Offline Storage',
        ],
      ),
      _createDomain(
        id: 'web_dev',
        name: 'Web Development',
        field: 'Tech',
        description: 'Build responsive websites and powerful web applications.',
        icon: LucideIcons.globe,
        color: Colors.cyan,
        cert: 'Meta Front-End Developer',
        skills: [
          'HTML/CSS/JS',
          'Frontend Frameworks',
          'Node.js/Backend',
          'Database Integration',
          'Web Security',
        ],
      ),
      _createDomain(
        id: 'ai_ml',
        name: 'Artificial Intelligence & ML',
        field: 'Tech',
        description:
            'Develop intelligent systems that learn and adapt from data.',
        icon: LucideIcons.brain,
        color: Colors.deepPurple,
        cert: 'Google Cloud ML Engineer',
        skills: [
          'Linear Algebra',
          'TensorFlow/PyTorch',
          'Neural Networks',
          'NLP & Computer Vision',
          'Model Deployment',
        ],
      ),
      _createDomain(
        id: 'data_sci',
        name: 'Data Science',
        field: 'Tech',
        description: 'Extract meaningful insights from large complex datasets.',
        icon: LucideIcons.database,
        color: Colors.purple,
        cert: 'IBM Data Science Professional',
        skills: [
          'Statistics',
          'Python/R',
          'EDA & Visualization',
          'Predictive Modeling',
          'Big Data Tools',
        ],
      ),
      _createDomain(
        id: 'data_eng',
        name: 'Data Engineering',
        field: 'Tech',
        description:
            'Build and optimize systems for data collection and storage.',
        icon: LucideIcons.layers,
        color: Colors.brown,
        cert: 'Google Professional Data Engineer',
        skills: [
          'ETL Pipelines',
          'SQL/NoSQL',
          'Spark/Kafka',
          'Data Warehousing',
          'Distributed Systems',
        ],
      ),

      // ☁️ INFRASTRUCTURE & SYSTEMS
      _createDomain(
        id: 'cloud_comp',
        name: 'Cloud Computing',
        field: 'Tech',
        description: 'Manage and deploy scalable infrastructure on the cloud.',
        icon: LucideIcons.cloud,
        color: Colors.lightBlue,
        cert: 'AWS Certified Solutions Architect',
        skills: [
          'Cloud Architecture',
          'Serverless',
          'Identity Management',
          'Cost Optimization',
          'Disaster Recovery',
        ],
      ),
      _createDomain(
        id: 'devops',
        name: 'DevOps Engineering',
        field: 'Tech',
        description: 'Bridge the gap between development and IT operations.',
        icon: LucideIcons.refreshCw,
        color: Colors.teal,
        cert: 'Certified Kubernetes Administrator',
        skills: [
          'CI/CD Pipelines',
          'Docker & K8s',
          'Infrastructure as Code',
          'Monitoring',
          'Automation',
        ],
      ),
      _createDomain(
        id: 'cybersec',
        name: 'Cybersecurity',
        field: 'Tech',
        description:
            'Protect systems, networks, and data from digital attacks.',
        icon: LucideIcons.shield,
        color: Colors.red,
        cert: 'CompTIA Security+',
        skills: [
          'Encryption',
          'Firewalls',
          'Incident Response',
          'Network Security',
          'Compliance',
        ],
      ),
      _createDomain(
        id: 'eth_hack',
        name: 'Ethical Hacking',
        field: 'Tech',
        description:
            'Legally hack into systems to identify and fix vulnerabilities.',
        icon: LucideIcons.terminal,
        color: Colors.green,
        cert: 'Certified Ethical Hacker (CEH)',
        skills: [
          'Pentesting',
          'Vulnerability Assessment',
          'Malware Analysis',
          'Exploitation',
          'Reporting',
        ],
      ),
      _createDomain(
        id: 'network_eng',
        name: 'Networking',
        field: 'Tech',
        description:
            'Design and manage communication networks for organizations.',
        icon: LucideIcons.server,
        color: Colors.orange,
        cert: 'Cisco CCNA',
        skills: [
          'TCP/IP & OSI',
          'Routing & Switching',
          'Network Security',
          'Wireless Systems',
          'VoIP',
        ],
      ),

      // 🎨 DESIGN & PRODUCT
      _createDomain(
        id: 'ui_ux',
        name: 'UI/UX Design',
        field: 'Tech',
        description: 'Craft intuitive and visually stunning user experiences.',
        icon: LucideIcons.palette,
        color: Colors.pink,
        cert: 'Google UX Design Professional',
        skills: [
          'User Research',
          'Wireframing',
          'Visual Design',
          'Prototyping',
          'Accessibility',
        ],
      ),
      _createDomain(
        id: 'prod_mgmt',
        name: 'Product Management',
        field: 'Tech',
        description: 'Lead the strategy, roadmap, and features of a product.',
        icon: LucideIcons.briefcase,
        color: Colors.amber,
        cert: 'Pragmatic Certified Product Manager',
        skills: [
          'Product Strategy',
          'Agile/Scrum',
          'Market Research',
          'Stakeholder Management',
          'Analytics',
        ],
      ),

      // 📊 BUSINESS & ANALYTICS
      _createDomain(
        id: 'bus_analytics',
        name: 'Business Analytics',
        field: 'Tech',
        description:
            'Analyze business data to drive data-driven decision making.',
        icon: LucideIcons.pieChart,
        color: Colors.blueGrey,
        cert: 'Certified Business Analysis Professional',
        skills: [
          'Data Visualization',
          'SQL',
          'Financial Modeling',
          'Decision Analysis',
          'Business Intel',
        ],
      ),
      _createDomain(
        id: 'dig_market',
        name: 'Digital Marketing',
        field: 'Tech',
        description: 'Promote brands and products through digital channels.',
        icon: LucideIcons.megaphone,
        color: Colors.redAccent,
        cert: 'Google Digital Marketing Professional',
        skills: [
          'SEO/SEM',
          'Content Strategy',
          'Social Media Analytics',
          'Email Marketing',
          'Brand Identity',
        ],
      ),

      // 🚀 EMERGING & SPECIALIZED
      _createDomain(
        id: 'blockchain',
        name: 'Blockchain Development',
        field: 'Tech',
        description: 'Build decentralized applications and smart contracts.',
        icon: LucideIcons.link,
        color: Colors.deepOrange,
        cert: 'Certified Blockchain Developer',
        skills: [
          'Cryptography',
          'Ethereum & Solidity',
          'Smart Contracts',
          'Web3.js',
          'Consensus Algorithms',
        ],
      ),
      _createDomain(
        id: 'iot',
        name: 'Internet of Things (IoT)',
        field: 'Tech',
        description: 'Connect and exchange data between physical devices.',
        icon: LucideIcons.cpu,
        color: Colors.lime,
        cert: 'IoT Graduate Certificate',
        skills: [
          'Embedded Systems',
          'Sensors & Actuators',
          'IoT Protocols (MQTT)',
          'Data Edge Computing',
          'IoT Security',
        ],
      ),
      _createDomain(
        id: 'ar_vr',
        name: 'AR / VR Development',
        field: 'Tech',
        description:
            'Create immersive augmented and virtual reality experiences.',
        icon: LucideIcons.monitor,
        color: Colors.purpleAccent,
        cert: 'Unity Certified Developer',
        skills: [
          '3D Modeling',
          'Unity/Unreal Engine',
          'Computer Vision',
          'UX for Immersive',
          'Spatial Audio',
        ],
      ),
      _createDomain(
        id: 'game_dev',
        name: 'Game Development',
        field: 'Tech',
        description: 'Develop engaging video games for various platforms.',
        icon: LucideIcons.gamepad2,
        color: Colors.lightGreen,
        cert: 'Unreal Engine Expert',
        skills: [
          'Game Mechanics',
          'C#/C++',
          'Physics Engines',
          'Level Design',
          'Graphics Rendering',
        ],
      ),
      _createDomain(
        id: 'tech_writing',
        name: 'Technical Writing',
        field: 'Tech',
        description:
            'Communicate complex technical info to users and developers.',
        icon: LucideIcons.penTool,
        color: Colors.grey,
        cert: 'Professional Technical Writer (PTW)',
        skills: [
          'Documentation Design',
          'API Writing',
          'UX Writing',
          'Information Architecture',
          'Proofreading',
        ],
      ),
    ];

    return [...techDomains, ...MedicalCommerceDomainData.getAll()];
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
          title: 'Step 1: Fundamentals',
          description:
              'Master the core basics of ${name.toLowerCase()} including foundation concepts and basic theory.',
        ),
        RoadmapStep(
          title: 'Step 2: Core Skills',
          description:
              'Develop essential skills like ${skills[0]} and ${skills[1]} to build a solid practical foundation.',
        ),
        RoadmapStep(
          title: 'Step 3: Tools & Frameworks',
          description:
              'Learn industry-standard tools and frameworks such as ${skills[2]} to accelerate development.',
        ),
        RoadmapStep(
          title: 'Step 4: Practical Projects',
          description:
              'Apply your knowledge by building real-world projects focused on ${skills[3]}.',
        ),
        RoadmapStep(
          title: 'Step 5: Advanced Concepts',
          description:
              'Deep dive into complex topics like ${skills[4]} and organizational best practices.',
        ),
        RoadmapStep(
          title: 'Step 6: Certification & Prep',
          description:
              'Prepare for professional industry roles and earn your $cert certification.',
          certification: cert,
        ),
      ],
    );
  }
}

/**
 * FUTURE-READY INTEGRATIONS & HOOKS
 * ---------------------------------
 * 1. AI-BASED RECOMMENDATIONS: 
 *    - Placeholder: In RoadmapProvider, plug in LLM API to analyze user's speed/errors 
 *      to dynamically swap Step 4/5 descriptions with custom learning paths.
 * 
 * 2. MENTOR GUIDANCE:
 *    - Placeholder: In RoadmapScreen, add a 'Talk to Mentor' FAB that queries 
 *      a MentorService filtering by domain.id.
 * 
 * 3. JOB & INTERNSHIP INTEGRATION:
 *    - Placeholder: In Step 6, add a 'View Jobs' button that fetches live data 
 *      from LinkedIn/Indeed APIs matching the domain.name keyword.
 */
