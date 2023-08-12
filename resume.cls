\ProvidesClass{resume}[2023/08/09 Resume Component]           % Name the class, separate description for version and info

% Load necessary packages
\LoadClass{article}                                                 % Loads the article class
\usepackage{hyperref}
\usepackage{graphicx}
\usepackage{array}

% Define class options for customization
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}       % Declares a class option of any unspecified option passing it to article class that uses the custom class like different font size in \documentclass[lizarazu_res, 12pt]{article}
\ProcessOptions\relax                                               % Processes options of article class

% Define commands for name, links, phone number, and email
\newcommand{\resumename}[1]{\def\@resumename{#1}}                   % New command takes one argument and sets internal macro of @resumename to specified value found in the first argument
\newcommand{\resumeemail}[1]{\def\@resumeemail{#1}}
\newcommand{\resumephone}[1]{\def\@resumephone{#1}}
\newcommand{\resumelinkedin}[1]{\def\@resumelinkedin{#1}}
\newcommand{\resumegithub}[1]{\def\@resumegithub{#1}}
\newcommand{\resumelocation}[1]{\def\@resumelocation{#1}}

% Default values (can be overridden by user)                        % Can be defined by the user, already made beforehand
\resumename{John Doe}
\resumeemail{johndoe@example.com}
\resumephone{123-456-7890}
\resumelinkedin{https://www.linkedin.com/in/johndoe}
\resumegithub{https://github.com/johndoe}
\resumelocation{Wyoming}


% Provide a command to set the resume name
\newcommand{\setName}[1]{\resumename{#1}}
% Provide a command to set the resume email
\newcommand{\setEmail}[1]{\resumeemail{#1}}
% Provide a command to set the resume phone number
\newcommand{\setPhone}[1]{\resumephone{#1}}
% Provide a command to set the resume link
\newcommand{\setLinkedIn}[1]{\resumelinkedin{#1}}
\newcommand{\setGitHub}[1]{\resumegithub{#1}}
\newcommand{\setLocation}[1]{\resumelocation{#1}}


% Redefine \maketitle to customize resume header (essentially making it your own aside from what was done in article)
\makeatletter
\renewcommand{\maketitle}{
  \centering
  \textbf{\huge \@resumename} \\                                   % Prints resume name in large/bond font
  % \vspace{0.2em}                                                    % Creates vertical space in between
  \begin{center}                                                % Creates a table to place things in
    \makebox[\textwidth] {
      \large \raisebox{-.4ex}{\includegraphics[height=1em]{icons/linkedin_small.png}} \href{\@resumelinkedin}{LinkedIn} ~$|$~
      \raisebox{-.4ex}{\includegraphics[height=1em]{icons/phone_small.png}} \@resumephone ~$|$~ 
      \raisebox{-.4ex}{\includegraphics[height=1em]{icons/gmail_small.png}} \href{mailto:\@resumeemail}{\@resumeemail} ~$|$~ 
      \raisebox{-.4ex}{\includegraphics[height=1em]{icons/github_small.png}} \href{\@resumegithub}{GitHub} ~$|$~
      \@resumelocation
    }
  \end{center}
  \par                                                              % End of the paragraph
}



\endinput                                                           % End of the class file