*** Settings ***
Resource    ../resources/common.robot
Library    Cumulocity

Suite Setup    Set Main Device

*** Test Cases ***

Initial values are published on startup
    ${values}=    Get Topic    config/#    2
    Should Not Be Empty    ${values}
    Should Contain    ${values}    config/c8y

Updating file triggers updated messages
    ${operation}=    Cumulocity.Execute Shell Command    sudo tedge config set run.lock_files false
    Operation Should Be SUCCESSFUL    ${operation}

    ${values}=    Get Topic    config/run    2
    Should Be Equal    ${values}    config/run {"lock_files":false}${\n}


*** Keywords ***
Get Topic
    [Arguments]    ${topic}    ${timeout}=5
    ${operation}=    Cumulocity.Execute Shell Command    mosquitto_sub -t '${topic}' -W ${timeout} -v || exit 0
    Operation Should Be SUCCESSFUL    ${operation}
    RETURN    ${operation.to_json()["c8y_Command"]["result"]}
