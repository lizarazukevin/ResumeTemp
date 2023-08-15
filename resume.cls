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
\LoadClass{article}           % Base article class is loaded
\usepackage{hyperref}         % Used for integrating links into documents
\usepackage{graphicx}         % Package for embedding small icons
\usepackage[parfill]{parskip} % Remove paragraph indentation
\usepackage{calc}             % Provides support for performing arithmetic calculations within the document
\usepackage{tikz}             % Useful for drawing various things
\usepackage{xstring}
\usepackage{tabularx}
\usepackage{ulem}

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
      \large \raisebox{-.4ex}{\includegraphics[height=1em]{icons/linkedin_small.png}} \href{\@resumelinkedin}{LinkedIn} ~\raisebox{-.4ex}{\includegraphics[height=1em]{icons/divider.png}}~
      \raisebox{-.4ex}{\includegraphics[height=1em]{icons/phone_small.png}} \@resumephone ~\raisebox{-.4ex}{\includegraphics[height=1em]{icons/divider.png}}~ 
      \raisebox{-.4ex}{\includegraphics[height=1em]{icons/gmail_small.png}} \href{mailto:\@resumeemail}{\@resumeemail} ~\raisebox{-.4ex}{\includegraphics[height=1em]{icons/divider.png}}~ 
      \raisebox{-.4ex}{\includegraphics[height=1em]{icons/github_small.png}} \href{\@resumegithub}{GitHub} ~\raisebox{-.4ex}{\includegraphics[height=1em]{icons/divider.png}}~
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
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Education Section - Commands and possible macros used in printing the education info

% Creates a new entry with formatted education arguments
\newcommand{\addEducation}[6]{
  \begin{flushleft}

    % Table format for degree, school name, location, and dates
    \begin{tabularx}{\textwidth}{p{7cm} X c r}
      {\scalebox{1.2}[1.1]{\large\bf #1}} & \centering\uline{\scalebox{1}[1]{\large\bf #2}} & {#3} & \textbf{#4}\\
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
\endinput                       % End of the class file

