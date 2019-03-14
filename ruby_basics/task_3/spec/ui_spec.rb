require 'ui/menus'

describe 'CLI' do
  it 'can input menu number' do
    # UI::Menus.main_menu.show
    # eval 'management'
    `osascript -e 'tell application "System Events" to keystroke "1"'`
    `osascript -e 'tell application "System Events" to key code 36'`
    # expect(output).to include('В системе нет станций')
  end
end
