%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% File: resume.cls
%% Author: Kevin Lizarazu-Ampuero
%% Description: Class file for resume components
%% Date: 08/09/2023
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Setup Section

% Class name and version/description
\ProvidesClass{resume}[2023/08/09 Resume Component]

% Load necessary packages
\LoadClass{article}               % Base article class is loaded
\usepackage[hidelinks]{hyperref}  % Used for integrating links into documents and hides the box
\usepackage{graphicx}             % Package for embedding small icons
\usepackage[parfill]{parskip}     % Remove paragraph indentation
\usepackage{calc}                 % Provides support for performing arithmetic calculations within the document
\usepackage{tikz}                 % Useful for drawing various things
\usepackage{tabularx}             % Can change the width of table sections
\usepackage{ulem}                 % Used for underlining text

% Define class options for customization
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}       % Declares a class option of any unspecified option passing it to article class
\ProcessOptions\relax                                               % Processes customized options for 

% Definitions for common measurements
\def\namesize{\huge}            % Size of the name at the top of the document
\def\addressskip{\smallskip}    % The space between the two address (or phone/email) lines
\def\sectionlineskip{\medskip}  % The space above the horizontal line for each section 
\def\nameskip{\bigskip}         % The space after your name at the top
\def\sectionskip{\medskip}      % The space after the heading section

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Title Section - Contains information about the user

% Define commands for name, links, phone number, and email that saves to internal macro
\newcommand{\resumename}[1]{\def\@resumename{#1}}
\newcommand{\resumeemail}[1]{\def\@resumeemail{#1}}
\newcommand{\resumephone}[1]{\def\@resumephone{#1}}
\newcommand{\resumelinkedin}[1]{\def\@resumelinkedin{#1}}
\newcommand{\resumegithub}[1]{\def\@resumegithub{#1}}
\newcommand{\resumelocation}[1]{\def\@resumelocation{#1}}

% Default values if not changed using commands made to set internal macros
\resumename{John Doe}
\resumeemail{johndoe@example.com}
\resumephone{123-456-7890}
\resumelinkedin{https://www.linkedin.com/in/johndoe}
\resumegithub{https://github.com/johndoe}
\resumelocation{Denver, CO}

% Setter methods to change default information to specified
\newcommand{\setName}[1]{\resumename{#1}}
\newcommand{\setEmail}[1]{\resumeemail{#1}}
\newcommand{\setPhone}[1]{\resumephone{#1}}
\newcommand{\setLinkedIn}[1]{\resumelinkedin{#1}}
\newcommand{\setGitHub}[1]{\resumegithub{#1}}
\newcommand{\setLocation}[1]{\resumelocation{#1}}

% Creates a new definition for how to make a title
\renewcommand{\maketitle}{
  \centering                        % Centers the bio information
  \textbf{\Huge \@resumename} \\    % Prints user's name in huge bold font
  \begin{center}                    % Center aligns the next section
    \makebox[\textwidth] {          % Creates a box so that it stays centered and doesn't clip
      % Contains information on the user's LinkedIn, phone number, email, GitHub, and location with icons
      \large \raisebox{-.4ex}{\includegraphics[height=1em]{icons/linkedin_small.png}} \href{\@resumelinkedin}{\uline{LinkedIn}} ~\raisebox{-.4ex}{\includegraphics[height=1em]{icons/divider.png}}~
      \raisebox{-.4ex}{\includegraphics[height=1em]{icons/phone_small.png}} \@resumephone ~\raisebox{-.4ex}{\includegraphics[height=1em]{icons/divider.png}}~ 
      \raisebox{-.4ex}{\includegraphics[height=1em]{icons/gmail_small.png}} \href{mailto:\@resumeemail}{\@resumeemail} ~\raisebox{-.4ex}{\includegraphics[height=1em]{icons/divider.png}}~ 
      \raisebox{-.4ex}{\includegraphics[height=1em]{icons/github_small.png}} \href{\@resumegithub}{\uline{GitHub}} ~\raisebox{-.4ex}{\includegraphics[height=1em]{icons/divider.png}}~
      \@resumelocation
    }
  \end{center}                      % Ends center-aligning here 
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Environnments - Makes it so that format doesn't strictly follow the article class

% Extract the first and remaining characters
\def\firstletter#1#2@{#1}
\def\remainingletters#1#2@{#2}

% Creates a new definition of repeating horizantal hrule but extends to hfill in thicker fashion
\renewcommand{\hrulefill}{\leavevmode\leaders\hrule height 1.4pt\hfill\kern 0pt}

% New environment meant to detach from the original page format to create a section of itself
\newenvironment{resSection}[1] {

  % Definitions
  \def\first{\firstletter#1@}
  \def\rest{\remainingletters#1@}

  % Creates the section title
  \sectionskip
  \MakeUppercase{\begin{flushleft} \Large \scalebox{1.4}[1.4]{\first} \!\!\!\! \scalebox{1}[1]{\rest} \hrulefill \end{flushleft}}

  % Handles the section lines here (can change value added to change the section title divisor length)
  \vspace{1.1ex}
  \newdimen\swidth
  \setbox0=\hbox{\MakeUppercase{\Large \scalebox{1.4}[1.4]{\first} \!\!\!\! \scalebox{1}[1]{\rest} + 10pt}}
  \swidth=\wd0
  \hrule height 1.4pt width \swidth

  % Handles the connecting line
  \begin{flushleft}
    % \vspace{-3.2ex}           % Rounded connecting line
    % \hspace{\swidth - 1ex}
    % \tikz\draw[black, very thick] (0,0) -- (0.0626,0.0074) -- (0.1123, 0.0277) -- (0.1279, 0.0371) -- (0.1636, 0.0664) -- (0.1884, 0.0956) -- (0.2078, 0.1282) -- (0.2247, 0.1753) -- (0.22,0.23);
    
    \vspace{-3.15ex}            % Straight connecting line
    \hspace{\swidth - 1.02ex}
    \tikz\draw[black, very thick] (0,0) -- (0.22,0.23);
  \end{flushleft}

  \vspace{-1ex}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Education Section - Commands and possible macros used in printing the education info

% Creates a new entry with formatted education arguments
\newcommand{\addEducation}[6]{
  \begin{flushleft}

    % Table format for degree, school name, location, and dates
    \begin{tabularx}{\textwidth}{p{7cm} X p{2.6cm} r}
      {\scalebox{1.2}[1.1]{\large\bf #1}} & \centering\uline{\scalebox{1}[1]{\large\bf #2}} & \centering{#3} & \textbf{#4}\\
    \end{tabularx} \\

    % Further description including focus, minor, and relevant coursework
    \vspace{1ex}
    \begin{itemize}
      % Itemizes the description of all degree names
      \item {#5}
      % Checks if there is a section for more description or relevant coursework
      \vspace{-1ex}
      \ifx&#6&\else
        \item {\textbf{Relevant Coursework: }#6}
      \fi
    \end{itemize}
  \end{flushleft}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Skills Section - Formatting manner in which skills are shown

% Use this for various technical skills you want to itemize and add
\newcommand{\addDesc}[1] {
  \begin{flushleft}
    \vspace{-1ex}
    \begin{itemize}
      \item {#1}
    \end{itemize}
  \end{flushleft}
}

% Alternative way of displaying skills where you want to showcase top 5
\newcommand{\addSoftSkill}[5] {
  \begin{flushleft}
    \begin{tabularx}{\textwidth}{X X X X X}
      \centering{\it #1} & \centering{\it #2} & \centering{\it #3} & \centering{\it #4} & \centering{\it #5}
    \end{tabularx}
  \end{flushleft}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Experience Section - Relevant work experience inside and outside of school

% Takes from the education section in title-like fashion
\newcommand{\addExperience}[4]{
  \begin{flushleft}
    % Table format for position, organization/company name, location, and dates (modified scaling to fit positions)
    \begin{tabularx}{\textwidth}{p{7cm} X p{2.6cm} r}
      {\scalebox{0.8}[0.8]{\large\bf #1}} & \centering\uline{\scalebox{1}[1]{\bf #2}} & \centering{\it #3} & \textbf{#4}\\
    \end{tabularx} \\
  \end{flushleft}
}

% To add descriptions we will reuse the addDesc command in the skills section

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Projects Section - Aimed to share personal and school projects not already mentioned

% Formats the title and main information before adding descriptors
\newcommand{\addProject}[3]{
  \begin{flushleft}
    % Table format for position, organization/company name, location, and dates (modified scaling to fit positions)
    \begin{tabularx}{\textwidth}{p{7cm} X r}
      {\scalebox{0.8}[0.8]{\large\bf #1}} & \centering{\it #2} & \textbf{#3}\\
    \end{tabularx} \\
  \end{flushleft}
}

% To add descriptions we will reuse the addDesc command in the skills section

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Organizations Section - All the groups we are a part of and extra description if needed

% Adding a single organization to clarify contributions and leadership
\newcommand{\addOrg}[3]{
  \begin{flushleft}
    \vspace{-1ex}
    \begin{tabularx}{\textwidth}{p{7cm} X r}
      {\scalebox{0.8}[0.8]{\large\bf #1}} & \centering{\it #2} & \textbf{#3}\\
    \end{tabularx} \\
  \end{flushleft}
}

% Only displays names of listed organizations/honors
\newcommand{\addOrgs}[1]{
  \begin{flushleft}
    \vspace{-1ex}
    \hspace{0.5ex}
    \scalebox{0.8}[0.8]{\large\textbf{Additionally:} {#1}}
  \end{flushleft}
}

% To add descriptions we will reuse the addDesc command in the skills section

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\endinput                       % End of the class file

