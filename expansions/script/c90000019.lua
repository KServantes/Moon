--Toxic Wild Flower
function c90000019.initial_effect(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,90000019)
	e1:SetCondition(c90000019.condition1)
	c:RegisterEffect(e1)
	--Tuner
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetOperation(c90000019.operation2)
	c:RegisterEffect(e2)
	--Damage
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EVENT_BE_MATERIAL)
	e3:SetCondition(c90000019.condition3)
	e3:SetTarget(c90000019.target3)
	e3:SetOperation(c90000019.operation3)
	c:RegisterEffect(e3)
end
function c90000019.filter1(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_EARTH)
end
function c90000019.condition1(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c90000019.filter1,tp,0,LOCATION_MZONE,1,nil)
end
function c90000019.operation2(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ADD_TYPE)
	e1:SetValue(TYPE_TUNER)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e:GetHandler():RegisterEffect(e1)
end
function c90000019.condition3(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO
end
function c90000019.target3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local val=Duel.GetMatchingGroupCount(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)*100
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(val)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,val)
end
function c90000019.operation3(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end