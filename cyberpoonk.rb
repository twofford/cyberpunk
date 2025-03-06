# frozen_string_literal: true

$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/lib"

require 'utility'

autoload :Ammo,                         'ammo'
autoload :Armor,                        'armor'
autoload :Attack,                       'attack'
autoload :Character,                    'character'
autoload :Check,                        'check'
autoload :Cyberdeck,                    'items'
autoload :Cybernetic,                   'cybernetic'
autoload :DamageAttributes,             'damage_attributes'
autoload :Die,                          'dice'
autoload :D4,                           'dice'
autoload :D6,                           'dice'
autoload :D8,                           'dice'
autoload :D10,                          'dice'
autoload :D12,                          'dice'
autoload :D20,                          'dice'
autoload :D100,                         'dice'
autoload :GameError,                    'errors'
autoload :OutOfRangeError,              'errors'
autoload :MisfireError,                 'errors'
autoload :UnknownDifficultyLevelError,  'errors'
autoload :UnknownDegreeOfSuccessError,  'errors'
autoload :UnknownWeaponTypeError,       'errors'
autoload :Feat,                         'feat'
autoload :Gun,                          'gun'
autoload :Item,                         'item'
autoload :MartialArt,                   'martial_art'
autoload :MeleeWeapon,                  'melee_weapon'
autoload :Mod,                          'mod'
autoload :RangedWeapon,                 'ranged_weapon'
autoload :Rules,                        'rules'
autoload :Skills,                       'skills'
autoload :Stats,                        'stats'
autoload :Weapon,                       'weapon'

# Monkey patch to make sig available everywhere
class Module
  include T::Sig
end
