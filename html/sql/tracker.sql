--configurations for sqlite3

PRAGMA FOREIGN_KEYs = ON;
.headers ON
.mode column

--drop tables

DROP TABLE IF EXISTS enrollment;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS occurrence;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS professor;
DROP TABLE IF EXISTS class;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS degree;
DROP TABLE IF EXISTS degree_type;
DROP TABLE IF EXISTS classroom;
DROP TABLE IF EXISTS janitor;
DROP TABLE IF EXISTS covid;
DROP TABLE IF EXISTS faculty;
DROP TABLE IF EXISTS person;

--CREATE TABLEs

CREATE TABLE person (
    id INTEGER PRIMARY KEY,   
    name TEXT NOT NULL,       --tag:
                              --1 = green (no contact with known sick people)       
    address TEXT,             --2 = yellow (indirect contact with a sick person)
    phone_number INTEGER     --3 = red (direct contact with a sick)
);

CREATE TABLE student (
    id INTEGER PRIMARY KEY REFERENCES person,
    degree INTEGER REFERENCES degree,
    faculty VARCHAR REFERENCES faculty
);

CREATE TABLE professor (
    id INTEGER PRIMARY KEY REFERENCES person,
    faculty VARCHAR REFERENCES faculty,
    email VARCHAR,
    classification TEXT
);

CREATE TABLE janitor (
    id INTEGER PRIMARY KEY REFERENCES person,
    email VARCHAR
);

CREATE TABLE faculty (
    acronym VARCHAR PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    address VARCHAR NOT NULL
);

CREATE TABLE classroom (
    code VARCHAR PRIMARY KEY, --e.g. "GA1", "101"...
    description TEXT, --e.g. "Auditório Geral 1" (opcional)
    faculty VARCHAR REFERENCES faculty,
    janitor INTEGER REFERENCES janitor
);

CREATE TABLE degree_type (
    code VARCHAR PRIMARY KEY, --e.g. '1'=1º ciclo, '2'=2º ciclo...
    name TEXT NOT NULL --e.g. licenciatura
);

CREATE TABLE degree (
    acronym VARCHAR PRIMARY KEY NOT NULL, --e.g. MIEEC
    name TEXT NOT NULL,                   --e.g. Mestrado Integrado em Engenharia Eletrotécnica e de Computadores
    faculty REFERENCES faculty,
    degree_type VARCHAR REFERENCES degree_type        
);

CREATE TABLE course (
    acronym VARCHAR PRIMARY KEY,                --e.g. SIBD
    name VARCHAR NOT NULL,                         --e.g. Sistemas de Informação e Bases de Dados
    degree VARCHAR NOT NULL REFERENCES degree
);

CREATE TABLE class (
    course VARCHAR,   --e.g. SIBD
    number VARCHAR, --e.g. 03
    max_students INTEGER,   --30
    PRIMARY KEY (course, number),
    CONSTRAINT course_fk FOREIGN KEY (course) REFERENCES course(acronym)
);

CREATE TABLE enrollment (
    id INTEGER PRIMARY KEY autoincrement,
    person_id INTEGER NOT NULL,
    course VARCHAR NOT NULL,
    class VARCHAR,
    date DATETIME NOT NULL,
    CONSTRAINT person_id_fk FOREIGN KEY (person_id) REFERENCES person(id),
    CONSTRAINT course_class_fk FOREIGN KEY (course,class) REFERENCES class(course,number)
);

CREATE TABLE occurrence (   --every time a class happens
    course VARCHAR class,
    class_number VARCHAR class,
    id INTEGER NOT NULL,
    classroom VARCHAR NOT NULL REFERENCES classroom,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    professor INTEGER REFERENCES person(id),
    PRIMARY KEY (course,class_number,id),
    FOREIGN KEY (course,class_number) REFERENCES class(course,number),
    CONSTRAINT start_time_less_than_end_time CHECK (start_time < end_time),
    CONSTRAINT start_time_within_semester CHECK (start_time between '2020-09-28 00:00:00' AND '2020-12-18 23:59:59'),
    CONSTRAINT end_time_within_semester CHECK (end_time between '2020-09-28 00:00:00' AND '2020-12-18 23:59:59')
);

CREATE TABLE attendance (
    id INTEGER PRIMARY KEY autoincrement,
    person_id INTEGER REFERENCES person,
    swipe DATETIME ,
    classroom VARCHAR NOT NULL REFERENCES classroom
);

CREATE TABLE covid (
    id INTEGER PRIMARY KEY autoincrement,
    person_id INTEGER REFERENCES person,
    result TEXT, 
    date DATETIME,
    CONSTRAINT test_result_valid CHECK (covid.result = 'positive' OR 'negative')
);
--INSERTS

--faculties:
INSERT INTO faculty (acronym,name,address)
VALUES ('FEUP',
        'Faculdade de Engenharia',
        'R. Dr. Roberto Frias s/n, 4200-465 Porto, Portugal');

INSERT INTO faculty (acronym,name,address)
VALUES ('FLUP',
        'Faculdade de Letras',
        'Via Panorâmica Edgar Cardoso s/n, 4150-564 Porto, Portugal');

INSERT INTO faculty (acronym,name,address)
VALUES ('FDUP',
        'Faculdade de Direito',
        'Rua dos Bragas 223, 4050-123 Porto, Portugal');

INSERT INTO faculty (acronym,name,address)
VALUES ('FEP',
        'Faculdade de Economia',
        'R. Dr. Roberto Frias 464, 4200-465 Porto, Portugal');


INSERT INTO faculty (acronym,name,address)
VALUES ('FBAUP',
        'Faculdade de Belas Artes',
        'Av. de Rodrigues de Freitas 265, 4049–021 Porto, Portugal');

--degree types:
INSERT INTO degree_type (code,name)
VALUES (1,
'Licenciatura');

INSERT INTO degree_type (code,name)
VALUES (2,
'Mestrado Integrado');

INSERT INTO degree_type (code,name)
VALUES (3,
'Mestrado');

INSERT INTO degree_type (code,name)
VALUES (4,
'Doutoramento');
--Degrees
--FEUP:
--1
INSERT INTO degree VALUES ('CINF', 'Licenciatura em Ciência da Informação', 'FEUP', 1);
INSERT INTO degree VALUES ('LCEEMG', 'Licenciatura em Ciências de Engenharia - Engenharia de Minas e Geo-Ambiente', 'FEUP', 1);
INSERT INTO degree VALUES ('CC', 'Licenciatura em Ciências da Comunicação: Jornalismo, Assessoria, Multimédia', 'FEUP', 1);
--2
INSERT INTO degree VALUES ('MIB', 'Mestrado Integrado em Bioengenharia', 'FEUP', 2);
INSERT INTO degree VALUES ('MIEA', 'Mestrado Integrado em Engenharia do Ambiente', 'FEUP', 2);
INSERT INTO degree VALUES ('MIEGI', 'Mestrado Integrado em Engenharia e Gestão Industrial', 'FEUP', 2);
INSERT INTO degree VALUES ('MIEEC', 'Mestrado Integrado em Engenharia Eletrotécnica e de Computadores', 'FEUP',2);
INSERT INTO degree VALUES ('MI:EF', 'Mestrado Integrado em Engenharia Física', 'FEUP',2);
INSERT INTO degree VALUES ('MIEIC', 'Mestrado Integrado em Engenharia Informática e Computação', 'FEUP',2);
INSERT INTO degree VALUES ('MIEC', 'Mestrado Integrado em Engenharia Civil', 'FEUP', 2);
INSERT INTO degree VALUES ('MIEM', 'Mestrado Integrado em Engenharia Mecânica', 'FEUP', 2);
INSERT INTO degree VALUES ('MIEMM', 'Mestrado Integrado em Engenharia Metalúrgica e de Materiais', 'FEUP', 2);
INSERT INTO degree VALUES ('MIEQ', 'Mestrado Integrado em Engenharia Química', 'FEUP', 2);

--3
INSERT INTO degree VALUES ('MDIP','Design Industrial e de Produto','FEUP',3);
INSERT INTO degree VALUES ('M:ARS','Mestrado em Avaliação e Remediação de Solos ','FEUP',3);
INSERT INTO degree VALUES ('MCI','Mestrado em Ciência da Informação','FEUP',3);
INSERT INTO degree VALUES ('MECC','Mestrado em Ciências da Comunicação','FEUP',3);
INSERT INTO degree VALUES ('MEB','Mestrado em Engenharia Biomédica','FEUP',3);
INSERT INTO degree VALUES ('MEMG','Mestrado em Engenharia de Minas e Geo-Ambiente','FEUP',3);
INSERT INTO degree VALUES ('MESHO','Mestrado em Engenharia de Segurança e Higiene Ocupacionais ','FEUP',3);
INSERT INTO degree VALUES ('MESG','Mestrado em Engenharia de Serviços e Gestão','FEUP',3);
INSERT INTO degree VALUES ('MESW','Mestrado em Engenharia de Software ','FEUP',3);
INSERT INTO degree VALUES ('MECD','Mestrado em Engenharia e Ciência de Dados ','FEUP',3);
INSERT INTO degree VALUES ('MESTEC','Mestrado em Estruturas de Engenharia Civil','FEUP',3);
INSERT INTO degree VALUES ('MGMU','Mestrado em Gestão da Mobilidade Urbana','FEUP',3);
INSERT INTO degree VALUES ('MIET','Mestrado em Inovação e Empreendedorismo Tecnológico ','FEUP',3);
INSERT INTO degree VALUES ('MMC','Mestrado em Mecânica Computacional','FEUP',3);
INSERT INTO degree VALUES ('MMSEGEO','Mestrado em Mecânica dos Solos e Engenharia Geotécnica ','FEUP',3);
INSERT INTO degree VALUES ('MM','Mestrado em Multimédia ','FEUP',3);
INSERT INTO degree VALUES ('MPPU','Mestrado em Planeamento e Projecto Urbano ','FEUP',3);
INSERT INTO degree VALUES ('MPRINCE','Mestrado em Projeto Integrado na Construção de Edifícios ','FEUP',3);
INSERT INTO degree VALUES ('MVCOMP','Mestrado em Visão por Computador ','FEUP',3);
--4
INSERT INTO degree VALUES ('PDMAPI','Doutoramento em Informática','FEUP',3);
INSERT INTO degree VALUES ('PDMATAPL','Doutoramento em Matemática Aplicada','FEUP',3);
INSERT INTO degree VALUES ('PDQUI','Doutoramento em Química','FEUP',3);
INSERT INTO degree VALUES ('PRODEB','Programa Doutoral em Engenharia Biomédica','FEUP',3);
INSERT INTO degree VALUES ('PRODEC','Programa Doutoral em Engenharia Civil','FEUP',3);
INSERT INTO degree VALUES ('PDEMGR','Programa Doutoral em Engenharia de Minas e Geo-Recursos','FEUP',3);
INSERT INTO degree VALUES ('PDEA','Programa Doutoral em Engenharia do Ambiente','FEUP',3);
INSERT INTO degree VALUES ('PRODEGI','Programa Doutoral em Engenharia e Gestão Industrial','FEUP',3);
INSERT INTO degree VALUES ('PDEPP','Programa Doutoral em Engenharia e Políticas Públicas Web','FEUP',3);
INSERT INTO degree VALUES ('PDEEC','Programa Doutoral em Engenharia Electrotécnica e de Computadores','FEUP',3);
INSERT INTO degree VALUES ('PRODEF','Programa Doutoral em Engenharia Física','FEUP',3);
INSERT INTO degree VALUES ('PRODEI','Programa Doutoral em Engenharia Informática Web','FEUP',3);
INSERT INTO degree VALUES ('PRODEM','Programa Doutoral em Engenharia Mecânica','FEUP',3);
INSERT INTO degree VALUES ('PDEMM','Programa Doutoral em Engenharia Metalúrgica e de Materiais','FEUP',3);
INSERT INTO degree VALUES ('PDEQB','Programa Doutoral em Engenharia Química e Biológica Web','FEUP',3);
INSERT INTO degree VALUES ('DLIT','Programa Doutoral em Líderes para Indústrias Tecnológicas','FEUP',3);
INSERT INTO degree VALUES ('PDMPA','Programa Doutoral em Materiais e Processamento Avançados','FEUP',3);
INSERT INTO degree VALUES ('PDMD','Programa Doutoral em Media Digitais Web','FEUP',3);
INSERT INTO degree VALUES ('PDPT','Programa Doutoral em Planeamento do Território','FEUP',3);
INSERT INTO degree VALUES ('DEMSSO','Programa Doutoral em Segurança e Saúde Ocupacionais Web','FEUP',3);
INSERT INTO degree VALUES ('PDST','Programa Doutoral em Sistemas de Transportes','FEUP',3);
INSERT INTO degree VALUES ('PDSSE','Programa Doutoral em Sistemas Sustentáveis de Energia','FEUP',3);
INSERT INTO degree VALUES ('MAP-T','Programa Doutoral em Telecomunicações','FEUP',3);
--FLUP:
--1
INSERT INTO degree VALUES ('LRI', 'Licenciatura em Línguas e Relações Internacionais', 'FLUP', 1);
INSERT INTO degree VALUES ('LLC', 'Licenciatura em Línguas, Literaturas e Culturas', 'FLUP', 1);
INSERT INTO degree VALUES ('HART', 'Licenciatura em História da Arte', 'FLUP', 1);
INSERT INTO degree VALUES ('SOCI', 'Licenciatura em Sociologia', 'FLUP', 1);
INSERT INTO degree VALUES ('FILO', 'Licenciatura em Filosofia', 'FLUP', 1);
INSERT INTO degree VALUES ('GEOGR', 'Licenciatura em Geografia', 'FLUP', 1);
INSERT INTO degree VALUES ('HISTO', 'Licenciatura em História', 'FLUP', 1);
--2

--Person:
INSERT INTO person VALUES (201700001,'Joao Miguel Tavares','Rua A, 1',1111111111);
INSERT INTO person VALUES (201700002,'Maria Carolina Alves','Rua B, 1',222222222);
INSERT INTO person VALUES (201700003,'Joana Ferreira','Rua C, 1',333333333);
INSERT INTO person VALUES (201700004,'Claudio Mendonça','Rua D, 1',444444444);
INSERT INTO person VALUES (201700005,'Luiz Soares','Rua E, 1',555555555);
INSERT INTO person VALUES (201700006,'Álvaro Silva','Rua F, 1',666666666);
INSERT INTO person VALUES (201700007,'Henrique Pereira','Rua G, 1',777777777);
INSERT INTO person VALUES (201902438,'Guilherme Knorst Magnago','Rua de Mouzinho da Silveira 44, 1º andar',911582067);

INSERT INTO person VALUES (656730,'Gonçalo Filipe Loureiro Campos Gonçalves','Rua do Gonçalo 33',984506516);
INSERT INTO person VALUES (636534,'Lázaro Gabriel Barros da Costa','Rua do Lázaro 10',940525605);
INSERT INTO person VALUES (123457,'Jurema Alvin','Endereço tal',789465135);
INSERT INTO person VALUES (123456,'Fulano Letreiro','Aquele lugar',987456423);

INSERT INTO person VALUES (202100001,'El janitor','Rua G, 1',878787878);
INSERT INTO person VALUES (202100002,'La janitora','Rua X, 1',787878787);


INSERT INTO student VALUES (201700001,'MIEEC','FEUP');
INSERT INTO student VALUES (201700002,'MIEEC','FEUP');
INSERT INTO student VALUES (201700003,'MIEEC','FEUP');
INSERT INTO student VALUES (201700004,'MIEEC','FEUP');
INSERT INTO student VALUES (201700005,'MIEEC','FEUP');
INSERT INTO student VALUES (201700006,'MIEEC','FEUP');
INSERT INTO student VALUES (201700007,'MIEEC','FEUP');
INSERT INTO student VALUES (201902438,'LRI','FLUP');

INSERT INTO professor VALUES (656730,'FEUP','gflcg@fe.up.pt','Docente Assistente Convidado');
INSERT INTO professor VALUES (636534,'FEUP','lazaro@fe.up.pt','Docente Assistente Convidado');
INSERT INTO professor VALUES (123457,'FEUP','jurema@fe.up.pt','Docente Assistente Convidado');

INSERT INTO professor VALUES (123456,'FLUP','fulano@letras.up.pt','Docente Assistente Convidado');

INSERT INTO janitor VALUES (202100001,'jjj@feup');
INSERT INTO janitor VALUES (202100002,'sss@feup');


--Courses:
--FEUP
--CINF
INSERT INTO course VALUES ('HCUL','História da Cultura','CINF');
INSERT INTO course VALUES ('INFBAS','Informática Básica','CINF');
INSERT INTO course VALUES ('LOG_CI','Lógica','CINF');
INSERT INTO course VALUES ('ISCI','Introdução aos Sistemas e Ciência da Informação','CINF');
INSERT INTO course VALUES ('TECOM','Técnicas de Expressão e Comunicação','CINF');
INSERT INTO course VALUES ('MD','Metainformação Descritiva','CINF');
INSERT INTO course VALUES ('DA_CI','Direito Administrativo','CINF');
INSERT INTO course VALUES ('II','Informação para a Internet','CINF');
INSERT INTO course VALUES ('OGE','Organização e Gestão de Empresas','CINF');
INSERT INTO course VALUES ('TMCI','Teoria e Metodologia da Ciência da Informação','CINF');
INSERT INTO course VALUES ('ASI','Análise de Sistemas de Informação','CINF');
INSERT INTO course VALUES ('GI','Gestão da Informação','CINF');
INSERT INTO course VALUES ('GSI','Gestão de Serviços de Informação','CINF');
INSERT INTO course VALUES ('RI','Recuperação da Informação','CINF');
--LCEEMG
INSERT INTO course VALUES ('QUIM1','Química I','LCEEMG');
INSERT INTO course VALUES ('PF','Projeto FEUP','LCEEMG');
INSERT INTO course VALUES ('G I','Geologia I','LCEEMG');
INSERT INTO course VALUES ('DT','Desenho Técnico','LCEEMG');
INSERT INTO course VALUES ('AM I','Análise Matemática I','LCEEMG');
INSERT INTO course VALUES ('FISI2','Física II','LCEEMG');
INSERT INTO course VALUES ('P','Petrologia','LCEEMG');
INSERT INTO course VALUES ('RM','Resistência de Materiais','LCEEMG');
INSERT INTO course VALUES ('QA','Química Ambiental','LCEEMG');
INSERT INTO course VALUES ('MN','Métodos Numéricos','LCEEMG');
INSERT INTO course VALUES ('AAD','Aquisição e Análise de Dados','LCEEMG');
INSERT INTO course VALUES ('TMPR I','Tratamento de Matérias Primas e Resíduos I','LCEEMG');
INSERT INTO course VALUES ('DM','Desmonte de Maciços','LCEEMG');
INSERT INTO course VALUES ('ECAP','Engenharia de Custos e Avaliação de Projetos','LCEEMG');
INSERT INTO course VALUES ('GA','Geologia Ambiental','LCEEMG');
--CC
INSERT INTO course VALUES ('TEPOR','Técnicas de Expressão de Português','CC');
INSERT INTO course VALUES ('HMCNT','História do Mundo Contemporâneo','CC');
INSERT INTO course VALUES ('TCOM','Teorias da Comunicação','CC');
INSERT INTO course VALUES ('METINV','Metodologia de Investigação','CC');
INSERT INTO course VALUES ('TME','Tecnologias dos Media','CC');
INSERT INTO course VALUES ('SEMCOM','Semiótica da Comunicação','CC');
INSERT INTO course VALUES ('TEJ_I_II','Técnicas de Expressão Jornalística II- Imprensa','CC');
INSERT INTO course VALUES ('TEJ_O_II','Técnicas de Expressão Jornalística II - Online','CC');
INSERT INTO course VALUES ('MARK','Marketing','CC');
INSERT INTO course VALUES ('CDINT','Comunicações Digitais e Internet','CC');
INSERT INTO course VALUES ('JORC','Jornalismo Comparado','CC');
INSERT INTO course VALUES ('AIJ','Atelier Integrado de Jornalismo','CC');
INSERT INTO course VALUES ('ECOM','Economia dos Media','CC');
INSERT INTO course VALUES ('LABSI','Laboratórios de Som e Imagem','CC');
--MIB
INSERT INTO course VALUES ('FQUI','Fundamentos de Química','MIB');
INSERT INTO course VALUES ('MAT1','Matemática I','MIB');
INSERT INTO course VALUES ('IPCOM','Introdução à Programação Científica','MIB');
INSERT INTO course VALUES ('FFIS','Fundamentos de Física','MIB');
INSERT INTO course VALUES ('CMBI','Ciências dos Materiais em Bioengenharia','MIB');
INSERT INTO course VALUES ('MGER','Microbiologia Geral','MIB');
INSERT INTO course VALUES ('MAT3','Matemática III','MIB');
INSERT INTO course VALUES ('MFLU','Mecânica dos Fluidos','MIB');
INSERT INTO course VALUES ('ELEL','Eletricidade e Eletromagnetismo','MIB');
INSERT INTO course VALUES ('FTRANS1','Fenómenos de Transferência I','MIB');
INSERT INTO course VALUES ('PSFI','Processamento de Sinais Fisiológicos','MIB');
INSERT INTO course VALUES ('ISBI','Interfaces em Sistemas Biológicos','MIB');
INSERT INTO course VALUES ('EDA','Estruturas de Dados e Algoritmos','MIB');
INSERT INTO course VALUES ('SAC','Sensores, Atuadores e Controlo','MIB');
INSERT INTO course VALUES ('AH','Anatomia Humana','MIB');
INSERT INTO course VALUES ('IINF','Imunologia e Infecção','MIB');
INSERT INTO course VALUES ('BMOL','Biointerfaces Moleculares','MIB');
INSERT INTO course VALUES ('EBMP','Engenharia e Biologia Molecular de Plantas','MIB');
INSERT INTO course VALUES ('FIS','Fisiologia','MIB');
INSERT INTO course VALUES ('BM','Bioquímica Microbiana','MIB');
INSERT INTO course VALUES ('EF','Engenharia das Fermentações','MIB');
INSERT INTO course VALUES ('MIA','Métodos Instrumentais de Análise','MIB');
INSERT INTO course VALUES ('FIB','Fenómenos Interfaciais em Biossistemas','MIB');
INSERT INTO course VALUES ('FTII','Fenómenos de Transferência II','MIB');
INSERT INTO course VALUES ('DACO','Diagnóstico Assistido por Computador','MIB');
INSERT INTO course VALUES ('BRM','Biónica e Robótica Médica','MIB');
INSERT INTO course VALUES ('RRTE','Reparação e Regeneração de Tecidos','MIB');
INSERT INTO course VALUES ('NANOS','Nanotecnologia em Saúde','MIB');
INSERT INTO course VALUES ('EC','Engenharia Celular','MIB');
INSERT INTO course VALUES ('ER','Engenharia Regenerativa','MIB');
INSERT INTO course VALUES ('AEFB','Análise Estrutural e Funcional em Bioengenharia','MIB');
INSERT INTO course VALUES ('IPCEC','Investigação Pré-Clínica e Ensaio Clínico','MIB');
INSERT INTO course VALUES ('TAMB','Tecnologia Ambiental','MIB');
INSERT INTO course VALUES ('PSBI','Processos de Separação em Biotecnologia','MIB');
INSERT INTO course VALUES ('QTPR','Química e Tecnologia dos Produtos','MIB');
INSERT INTO course VALUES ('TALI','Tecnologia Alimentar','MIB');
INSERT INTO course VALUES ('EMC','Engenharia Metabólica e Celular','MIB');
INSERT INTO course VALUES ('EG','Economia e Gestão','MIB');
INSERT INTO course VALUES ('IB','Inovação em Biodesign','MIB');
INSERT INTO course VALUES ('PEBM','Projeto de Engenharia Biomédica','MIB');
INSERT INTO course VALUES ('NN','Nanoterapêutica e Nanodiagnóstico','MIB');
INSERT INTO course VALUES ('PBM','Projeto de Bioengenharia Molecular','MIB');
INSERT INTO course VALUES ('BIOI','Bioinformática','MIB');
INSERT INTO course VALUES ('SGQU','Sistemas de Gestão da Qualidade','MIB');
INSERT INTO course VALUES ('SPI','Seminários e Projeto de Investigação','MIB');
INSERT INTO course VALUES ('PEB','Projeto de Engenharia Biológica','MIB');
INSERT INTO course VALUES ('EMPIN','Empreendedorismo e Inovação','MIB');
--MIEC
INSERT INTO course VALUES ('COMP','Computação','MIEC');
INSERT INTO course VALUES ('DTEC','Desenho Técnico','MIEC');
INSERT INTO course VALUES ('HECI','História da Engenharia Civil','MIEC');
INSERT INTO course VALUES ('AMAT1','Análise Matemática 1','MIEC');
INSERT INTO course VALUES ('RMAT1','Resistência dos Materiais 1','MIEC');
INSERT INTO course VALUES ('GENG','Geologia de Engenharia','MIEC');
INSERT INTO course VALUES ('MECA2','Mecânica 2','MIEC');
INSERT INTO course VALUES ('IASO','Impactes Ambientais e Sociais','MIEC');
INSERT INTO course VALUES ('AMAT3','Análise Matemática 3','MIEC');
INSERT INTO course VALUES ('MCON1','Materiais de Construção 1','MIEC');
INSERT INTO course VALUES ('IOPE','Investigação Operacional','MIEC');
INSERT INTO course VALUES ('FCON','Física das Construções','MIEC');
INSERT INTO course VALUES ('HGER2','Hidráulica Geral 2','MIEC');
INSERT INTO course VALUES ('TEST1','Teoria das Estruturas 1','MIEC');
--MIEEC
INSERT INTO course VALUES ('PROG1','Programação 1','MIEEC');
INSERT INTO course VALUES ('LSDI','Laboratório de Sistemas Digitais','MIEEC');
INSERT INTO course VALUES ('ALGE','Álgebra','MIEEC');
INSERT INTO course VALUES ('MNUM','Métodos Numéricos','MIEEC');
INSERT INTO course VALUES ('TSIN','Teoria do Sinal','MIEEC');
INSERT INTO course VALUES ('ELEM','Electromagnetismo','MIEEC');
INSERT INTO course VALUES ('PEST','Probabilidades e Estatística','MIEEC');
INSERT INTO course VALUES ('CIR2','Circuitos 2','MIEEC');
INSERT INTO course VALUES ('ELEC2','Electrónica 2','MIEEC');
INSERT INTO course VALUES ('SCON','Sistemas e Controlo','MIEEC');
INSERT INTO course VALUES ('OELE','Ondas Electromagnéticas','MIEEC');
INSERT INTO course VALUES ('RCOM','Redes de Computadores','MIEEC');
INSERT INTO course VALUES ('FTEL2','Fundamentos de Telecomunicações 2','MIEEC');
INSERT INTO course VALUES ('LPRO','Laboratório de Programação','MIEEC');
INSERT INTO course VALUES ('PDI','Preparação da Dissertação','MIEEC');
INSERT INTO course VALUES ('SETEC','Sistemas de Engenharia - Telecomunicações, Electrónica e Computadores','MIEEC');
INSERT INTO course VALUES ('SIBD','Sistemas de Informação e Bases de Dados','MIEEC');



--Classes:
--SIBD01
INSERT INTO class (course,number,max_students) VALUES ('SIBD', '03', 35);
INSERT INTO class (course,number,max_students) VALUES ('SIBD', '02', 35);

--Enrollment:
INSERT INTO enrollment VALUES (null,201902438,'SIBD','03','2020-09-05 10:14:55');

--Classroom:
--FEUP
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('EAD','Aula a Distância','FEUP',NULL);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('A101','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('A102','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('A103','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('A104','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('A105','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('A106','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('A107','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('A108','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('A109','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('A110','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('A201','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('A203','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('A204','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('A205','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('A206','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('A207','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('A208','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('A209','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('A210','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('B101','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('B102','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('B103','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('B104','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('B105','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('B106','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('B107','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('B108','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('B109','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('B110','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('B201','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('B202','Sala de Aula Computadores - Ed. B','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('B203','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('B204','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('B205','Sala de Aula Computadores - Ed. B','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('B206','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('B207','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('B208','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('B209','Sala de Aula','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('B210','Sala de Aula','FEUP',202100001);

--FLUP
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('G103','Sala de Aula Geral 103','FLUP',202100002);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('G104','Sala de Aula Geral 104','FLUP',202100002);

--Occurrence:
--SIBD03
INSERT INTO occurrence VALUES ('SIBD','03',1,'B205','2020-09-29 16:30:00','2020-09-29 18:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','03',2,'EAD','2020-09-30 17:30:00','2020-09-30 19:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','03',3,'B205','2020-10-06 16:30:00','2020-10-06 18:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','03',4,'EAD','2020-10-07 17:30:00','2020-10-07 19:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','03',5,'B205','2020-10-13 16:30:00','2020-10-13 18:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','03',6,'EAD','2020-10-14 17:30:00','2020-10-14 19:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','03',7,'B205','2020-10-20 16:30:00','2020-10-20 18:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','03',8,'EAD','2020-10-21 17:30:00','2020-10-21 19:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','03',9,'B205','2020-10-27 16:30:00','2020-10-27 18:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','03',10,'EAD','2020-10-28 17:30:00','2020-10-28 19:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','03',11,'B205','2020-11-03 16:30:00','2020-11-03 18:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','03',12,'EAD','2020-11-04 17:30:00','2020-11-04 19:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','03',13,'B205','2020-11-10 16:30:00','2020-11-10 18:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','03',14,'EAD','2020-11-11 17:30:00','2020-11-11 19:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','03',15,'B205','2020-11-17 16:30:00','2020-11-17 18:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','03',16,'EAD','2020-11-18 17:30:00','2020-11-18 19:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','03',17,'B205','2020-11-24 16:30:00','2020-11-24 18:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','03',18,'EAD','2020-11-25 17:30:00','2020-11-25 19:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','03',19,'B205','2020-12-01 16:30:00','2020-12-01 18:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','03',20,'EAD','2020-12-02 17:30:00','2020-12-02 19:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','03',21,'B205','2020-12-08 16:30:00','2020-12-08 18:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','03',22,'EAD','2020-12-09 17:30:00','2020-12-09 19:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','03',23,'B205','2020-12-15 16:30:00','2020-12-15 18:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','03',24,'EAD','2020-12-16 17:30:00','2020-12-16 19:30:00',656730);
--SIBD02
INSERT INTO occurrence VALUES ('SIBD','02',1,'B202','2020-09-28 15:30:00','2020-09-29 18:30:00',636534);
INSERT INTO occurrence VALUES ('SIBD','02',2,'EAD','2020-09-30 17:30:00','2020-09-30 19:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','02',3,'B202','2020-10-05 15:30:00','2020-10-06 18:30:00',636534);
INSERT INTO occurrence VALUES ('SIBD','02',4,'EAD','2020-10-07 17:30:00','2020-10-07 19:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','02',5,'B202','2020-10-12 15:30:00','2020-10-13 18:30:00',636534);
INSERT INTO occurrence VALUES ('SIBD','02',6,'EAD','2020-10-14 17:30:00','2020-10-14 19:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','02',7,'B202','2020-10-19 15:30:00','2020-10-20 18:30:00',636534);
INSERT INTO occurrence VALUES ('SIBD','02',8,'EAD','2020-10-21 17:30:00','2020-10-21 19:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','02',9,'B202','2020-10-26 15:30:00','2020-10-27 18:30:00',636534);
INSERT INTO occurrence VALUES ('SIBD','02',10,'EAD','2020-10-28 17:30:00','2020-10-28 19:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','02',11,'B202','2020-11-02 15:30:00','2020-11-03 18:30:00',636534);
INSERT INTO occurrence VALUES ('SIBD','02',12,'EAD','2020-11-04 17:30:00','2020-11-04 19:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','02',13,'B202','2020-11-09 15:30:00','2020-11-10 18:30:00',636534);
INSERT INTO occurrence VALUES ('SIBD','02',14,'EAD','2020-11-11 17:30:00','2020-11-11 19:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','02',15,'B202','2020-11-16 15:30:00','2020-11-17 18:30:00',636534);
INSERT INTO occurrence VALUES ('SIBD','02',16,'EAD','2020-11-18 17:30:00','2020-11-18 19:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','02',17,'B202','2020-11-23 15:30:00','2020-11-24 18:30:00',636534);
INSERT INTO occurrence VALUES ('SIBD','02',18,'EAD','2020-11-25 17:30:00','2020-11-25 19:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','02',19,'B202','2020-11-30 15:30:00','2020-12-01 18:30:00',636534);
INSERT INTO occurrence VALUES ('SIBD','02',20,'EAD','2020-12-02 17:30:00','2020-12-02 19:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','02',21,'B202','2020-12-07 15:30:00','2020-12-08 18:30:00',636534);
INSERT INTO occurrence VALUES ('SIBD','02',22,'EAD','2020-12-09 17:30:00','2020-12-09 19:30:00',656730);
INSERT INTO occurrence VALUES ('SIBD','02',23,'B202','2020-12-14 15:30:00','2020-12-15 18:30:00',636534);
INSERT INTO occurrence VALUES ('SIBD','02',24,'EAD','2020-12-16 17:30:00','2020-12-16 19:30:00',656730);

--attendance:
INSERT INTO attendance VALUES (NULL,201700001,'2020-09-28 12:55:23','B205');
INSERT INTO attendance VALUES (NULL,201700002,'2020-09-29 16:34:10','B205');
INSERT INTO attendance VALUES (NULL,201700003,'2020-09-29 16:33:10','B205');
INSERT INTO attendance VALUES (NULL,201700004,'2020-09-29 16:31:10','B202');

INSERT INTO attendance VALUES (NULL,201700001,'2020-09-29 16:33:10','B205');

INSERT INTO attendance VALUES (NULL,201700001,'2020-09-30 17:33:10','B205');
INSERT INTO attendance VALUES (NULL,201700005,'2020-09-30 17:32:10','B205');
INSERT INTO attendance VALUES (NULL,201700006,'2020-09-30 17:31:10','B205');

--covid:
INSERT INTO covid VALUES (NULL,201700001, 'positive', '2020-10-09');
INSERT INTO covid VALUES (NULL,201700006, 'positive', '2020-10-20');

-- testing queries for interrogating the database later

--select student with email (no need to store email as
--a variable for students):
-- SELECT *, 'up' || id || '@' || faculty || '.up.pt' AS email
-- FROM student
-- join person using (id);



 