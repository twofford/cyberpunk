# frozen_string_literal: true

class Character
  DEFAULT_HP = 10

  attr_reader :name, :stats, :skills, :feats, :items, :cybernetics, :hp

  alias hit_points hp
  alias equipment items
  alias cyberware cybernetics

  def initialize(name:, stats:, skills:, feats: [], items: [], cybernetics: [])
    @name = name
    @stats = stats
    @skills = skills
    @feats = feats
    @items = items
    @cybernetics = cybernetics
    @hp = DEFAULT_HP + @stats.brawn

    ## Allows `char.brawn`, `char.marksmanship`
    ## Instead of `char.stats.brawn`, `char.skills.marksmanship`
    define_stat_attr_readers
    define_skill_attr_readers
  end

  def roll_check_vs_dc(dc:, stat:, skill:)
    modified_roll = roll_check(stat: stat, skill: skill)

    calculate_degree_of_success(dc: dc, roll: modified_roll)
  end

  ## Works exactly like #roll_check_vs_dc but handles misfires for guns
  def roll_attack_check_vs_dc(weapon:, range_to_target:)
    raw_roll = D20.roll
    return :misfire if weapon.misfired?(roll: raw_roll)

    dc = weapon.dc_for_target(range_to_target: range_to_target)
    stat, skill = weapon.stat_and_skill(user: self)
    modified_roll = raw_roll + stats.send(stat) + skills.send(skill)

    calculate_degree_of_success(dc: dc, roll: modified_roll)
  end

  def make_ranged_attack(weapon:, range_to_target:)
    result = roll_attack_check_vs_dc(weapon: weapon, range_to_target: range_to_target)
    case result
    when :full
      weapon.roll_crit_damge
    when :partial
      weapon.roll_damage
    when :fail
      :miss
    when :misfire
      :misfire
    end
  end

  private

  def define_stat_attr_readers
    define_instance_var_attr_readers(obj: stats)
  end

  def define_skill_attr_readers
    define_instance_var_attr_readers(obj: skills)
  end

  def roll_check(stat: nil, skill: nil)
    D20.roll + stats.send(stat) + skills.send(skill)
  end

  def calculate_degree_of_success(dc:, roll:)
    Rules::DIFFICULTY_CLASSES[dc].each do |degree, range|
      return degree if range.include?(roll)
    end
  end
end
