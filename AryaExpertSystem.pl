% Facts about different types of information
information_type(document).
information_type(image).
information_type(video).
information_type(audio).

% Facts about different storage options
storage_option(local).
storage_option(cloud).

% Rules to infer suitable storage options based on information type
suitable_storage_option(document, local).
suitable_storage_option(image, local).
suitable_storage_option(video, cloud).
suitable_storage_option(audio, cloud).

% Define rules for responses to user queries
response(storage_option(Type), Response) :-
    suitable_storage_option(Type, Storage),
    format(atom(Response), 'For a ~w, suitable storage option is ~w.', [Type, Storage]), !.
response(_, 'I'm sorry, I'm not sure how to help with that. Please provide valid input.').

% Define a predicate to handle user queries
information_management(Query, Response) :-
    response(Query, Response), !.
information_management(_, 'I'm sorry, I didn't understand that. Can you please repeat?').

% Define a predicate to start the interaction
start_interaction :-
    write('Welcome to the Information Management Expert System. How can I assist you today?'), nl,
    interaction_loop.

% Define a predicate to handle the interaction loop
interaction_loop :-
    read_user_input(Input),
    process_input(Input),
    interaction_loop.

% Define a predicate to read user input
read_user_input(Input) :-
    write('> '),
    read_line_to_string(user_input, Input).

% Define a predicate to process user input and generate response
process_input(Input) :-
    % Convert input to lowercase for case insensitivity
    downcase_atom(Input, LowerInput),
    % Call information_management to generate response
    information_management(LowerInput, Response),
    % Output response to user
    format('~w~n', [Response]).
