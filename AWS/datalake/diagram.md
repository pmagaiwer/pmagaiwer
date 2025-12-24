flowchart TB
    subgraph Sources["Fontes de Dados"]
        A1["Aplicações"]
        A2["Bancos de Dados"]
        A3["APIs Externas"]
        A4["Arquivos Batch"]
    end

    subgraph Ingestion["Ingestão"]
        B1["EventBridge"]
        B2["AWS DMS"]
        B3["AWS Transfer"]
    end

    subgraph Storage["Data Lake - Amazon S3"]
        C1["RAW Zone"]
        C2["PROCESSED Zone"]
        C3["CURATED Zone"]
    end

    subgraph Processing["Processamento"]
        D1["AWS Glue Jobs"]
        D2["Amazon EMR (Spark)"]
    end

    subgraph Catalog["Catálogo e Governança"]
        E1["Glue Data Catalog"]
        E2["Lake Formation"]
    end

    subgraph Analytics["Consumo e Analytics"]
        F1["Amazon Athena"]
        F2["Amazon QuickSight"]
        F3["Data Science / ML"]
    end

    subgraph Observability["Observabilidade"]
        G1["Amazon CloudWatch"]
        G2["CloudWatch Alarms"]
    end

    A1 --> B1 --> C1
    A2 --> B2 --> C1
    A3 --> B1 --> C1
    A4 --> B3 --> C1

    C1 --> D1 --> C2
    C2 --> D2 --> C3

    C1 --> E1
    C2 --> E1
    C3 --> E1

    E2 --> E1

    C3 --> F1 --> F2
    C3 --> F3

    D1 --> G1
    D2 --> G1
    F1 --> G1
    G1 --> G2
